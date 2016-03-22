class UsersController < ApplicationController
  def new
    @user= User.new
  end

  def index
    @users = User.all
  end

  def create
    @user= User.create user_params
    if @user.persisted?
      session[:user_id] = @user.id
      flash[:success] = "Register successfully"
      redirect_to messages_path
    else
      flash.now[:error] = "Error: #{@user.errors.full_messages.to_sentence}"
      render 'new'
    end
  end

  def friend_request
    @friend = current_user.friends.build(:to_id => params[:id], accepted: "true") # accept by default
    if @friend.save
      redirect_to messages_path, flash: {success: "Friend added"}
    else
      redirect_to messages_path, flash: {error: "Unable to request friendable"}
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
