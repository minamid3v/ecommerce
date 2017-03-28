class UsersController < ApplicationController
  before_action :load_user, only: [:show, :update]
  before_action :correct_user, only: [:edit, :update, :show]
  before_action :logged_in_user, except: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      login @user
      flash[:success] = t "success.signup"
      redirect_to @user
    else
      render :new
    end
  end

  def show
    @recently_viewed_products = recently_viewed_products.reverse
      .paginate page: params[:page], per_page: Settings.paginate.recently_viewed
    @orders = current_user.orders.paginate page: params[:order_page],
      per_page: Settings.paginate.user_orders
    @suggested_products = current_user.suggested_products.paginate page: params[:suggest_page],
      per_page: Settings.paginate.suggested_products
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "success.update"
      redirect_to @user
    else
      flash[:danger] = t "error.update_failed"
      render :edit
    end
  end

  private
  def load_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t "error.user_not_found"
      redirect_to root_url
    end
  end

  def user_params
    params.require(:user).permit :user_name, :email, :password,
      :password_confirmation, :profile_image
  end

  def correct_user
    @user = User.find_by id: params[:id]
    if @user.nil?
      flash[:danger] = t "user_not_found"
      redirect_to root_url
    else
      unless @user == current_user
        flash[:danger] = t "user_not_found"
        redirect_to root_url
      end
    end
  end
end
