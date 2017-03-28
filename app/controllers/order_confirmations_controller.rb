class OrderConfirmationsController < ApplicationController
  before_action :load_user_order, only: :edit

  def edit
    if @user && @user.id == @order.user_id && @order && @order.order_status_id == 1 && @order.authenticated?(:confirmation, params[:id])
      @order.confirm
      login @user
      flash[:success] = t "success.order_approve"
      redirect_to @user
    else
      flash[:danger] = t "error.invalid_order"
      redirect_to root_path
    end
  end

  private

  def load_user_order
    @order = Order.find_by id: params[:order_id]
    @user = User.find_by email: params[:email]
  end

  def check_valid_order user, order
    user && user.id == order.user_id && order && order.order_status_id = 1 && order.authenticated(:confirmation, params[:id])
  end

end
