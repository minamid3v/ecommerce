class OrdersController < ApplicationController
  include ApplicationHelper

  before_action :logged_in_user
  before_action :load_order, only: :show
  def create
    @order = current_user.orders.build order_params
    if SaveOrderService.new(@order, current_cart, current_user).save_order?
      flash[:info] = t "success.order_success"
      redirect_to carts_path
    else
      flash_slq_error @order
    end
  end

  def show
    @order_details = @order.order_details.paginate page: params[:page],
      per_page: Settings.paginate.order_detail
  end

  private

  def order_params
    params.require(:order).permit :order_status_id, :address, :address, :phone,
      :full_name
  end

  def flash_slq_error object
    flash[:danger] = []
    object.errors.full_messages.each do |message|
      flash[:danger]<<message
    end
    redirect_to :back
  end

  def add_order_item
    current_cart.products.each do |product|
      order_detail = @order.order_details.build product_id: product.id,
        quantity: (current_cart.quantity product), price: product.price
      unless order_detail.save!
        flash_slq_error order_item
      end
    end
  end

  def load_order
    @order = Order.find_by id: params[:id]
    unless @order
      flash[:danger] = t "error.order_not_found"
      redirect_to :back
    end
  end
end
