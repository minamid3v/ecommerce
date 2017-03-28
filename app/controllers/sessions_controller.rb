class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by user_name: params[:sessions][:user_name].downcase
    if user && user.authenticate(params[:sessions][:password])
      login user
      params[:sessions][:remember_me] == Settings.login.remember_me ? remember(user): forget(user)
      redirect_back_or user
    else
      flash.now[:danger] = t "login.invalid_email_password"
      render :new
    end
  end

  def destroy
    logout if logged_in?
    redirect_to root_path
  end
end
