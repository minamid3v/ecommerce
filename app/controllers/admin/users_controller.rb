class Admin::UsersController < ApplicationController
  before_action :admin_user
  before_action :load_user, only: :destroy
  before_action :load_all_user, only: :index
  def index
  end

  def destroy
    if @user.destroy
      flash[:success] = t "success.delete"
      load_all_user
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = t "error.delete"
      load_all_user
      respond_to do |format|
        format.js
      end
    end
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = "error.user_not_found"
      redirect_to admin_users
    end
  end

  def load_all_user
    @users = User.by_name_email(params[:keyword]).paginate page: params[:page],
      per_page: Settings.paginate.admin_users
  end
end
