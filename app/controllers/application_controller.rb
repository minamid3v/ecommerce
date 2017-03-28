class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include ProductsHelper
  include CartsHelper

  private

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "error.please_log_in"
      redirect_to login_path
    end
  end

  def correct_user
    @user = User.find_by id: params[:id]
    if @user.nil? || !current_user.is_user?(@user)
      flash[:danger] = t "error.user_not_found"
      redirect_to root_url
    end
  end

  def admin_user
    unless current_user.is_admin?
      redirect_to root_path
      flash[:danger] = t "error.permission_denied"
    end
  end

  def get_price_params
    price_str = params[:price]
    if price_str.present?
      prices = price_str.split(",")
      @max_price = prices.last
      @min_price = prices.first
    end
  end
end
