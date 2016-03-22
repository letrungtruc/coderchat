class SessionsController < ApplicationController
  def new
  end

  def destroy
    session[:user_id]= nil
    flash[:success] = "Logout successfully"
    redirect_to root_path
  end

  def create
    if @user= User.find_by(email: params[:email]) and @user.authenticate(params[:password])
      session[:user_id] = @user.id
      # this should redirect to message page, temporary root_path
      redirect_to messages_path, flash: {success: "Login successfully"}
    else
      flash.now[:error] = "Invalid username or password."
      render 'new'
    end
  end
end
