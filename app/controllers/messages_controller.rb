class MessagesController < ApplicationController
  def index
    @type = params[:type] || 'incomming'
    if @type == 'incomming'
      @messages = current_user.incomming_messages.order created_at: :desc
    elsif @type == 'outcomming'
      @messages = current_user.outcomming_messages.order created_at: :desc
    else
      @messages = []
    end
  end

  def new
    @friends = current_user.active_friend  + current_user.passive_friend
  end

  def create
    reciever_id = params[:message][:reciever_id]
    body = params[:message][:body]

    if reciever_id.nil? || reciever_id.empty?
      redirect_to new_message_path, flash: {error: 'Cannot send message. You must choose recipient and type content.'}
      return
    end

    message = Message.new
    message.body = body
    reciever = User.find(reciever_id)
    message.reciever = reciever
    message.sender = current_user

    if message.save
      redirect_to messages_path(type: 'outcomming'), flash: {success: "Send message to #{reciever.name} successfully"}
    else
      redirect_to new_message_path, flash: {error: 'Cannot send message. You must choose recipient and type content.'}
    end
  end

  def show
    message_id = params[:id]
    @message = Message.find(message_id)
    @read = @message.read
    unless (@message.reciever == current_user)
      redirect_to messages_path, flash: {error: 'You are not recipient of this message'}
    else
      unless @read
        @message.read = true
        @message.save!
      end
    end
  end

end
