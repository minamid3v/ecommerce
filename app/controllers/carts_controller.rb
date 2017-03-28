class CartsController < ApplicationController
  before_action :update_session_cart, only: [:create, :update]
  before_action :destroy_session_cart, only: :destroy
  before_action :logged_in_user

  def create
  end

  def update
  end

  def destroy
  end

  def index
    @order = Order.new
  end

  private

  def update_session_cart
    load_product
    if @product.is_out_of_stock? params[:quantity].to_i
      flash.now[:danger] = t "error.product_out_of_stock"
    else
      @current_cart = current_cart
      if @product.update_attributes quantity: @product.quantity - params[:quantity].to_i
        @current_cart.add @product, params[:quantity]
      else
        flash[:danger] = t "error.add_cart_failed"
      end
    end
  end

  def destroy_session_cart
    load_product
    @current_cart = current_cart
    @product.update_attributes quantity: @product.quantity + @current_cart.quantity(@product)
    @current_cart.remove @product
  end

  def load_product
    @product = Product.find_by id: params[:product_id].to_i
    unless @product
      flash.now[:danger] = t "error.product_not_found"
      redirect_to :back
    end
  end
end
