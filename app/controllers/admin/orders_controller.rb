class Admin::OrdersController < ApplicationController
  before_action :admin_user
  before_action :load_order, only: [:show, :destroy, :update]

  def index
    @orders = Order.by_status_id(params[:status_id])
      .paginate page: params[:page], per_page: Settings.paginate.admin_orders
  end

  def show
  end

  def update
    case params[:order_action]
    when "reject"
      if @order.reject?
        flash[:success] = t "success.shipped"
        redirect_to admin_orders_path
      else
        flash[:danger] = t "error.update_failed"
        redirect_to admin_order_path
      end
    when "ship"
      if @order.ship?
        flash[:success] = t "success.shipped"
        redirect_to admin_orders_path
      else
        flash[:danger] = t "error.update_failed"
        redirect_to admin_order_path
      end
    end
  end

  private

  def load_order
    @order = Order.find_by id: params[:id]
    unless @order
      flash[:danger] = t "error.order_not_found"
      redirect_to admin_orders_path
    end
  end
end
