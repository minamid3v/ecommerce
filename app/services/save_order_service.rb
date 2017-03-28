class SaveOrderService
  attr_accessor :order, :current_cart, :current_user

  def initialize order, current_cart, current_user
    @order = order
    @current_cart = current_cart
    @current_user = current_user
  end

  def save_order?
    begin
      @order.order_status_id = Settings.order.status_default
      ActiveRecord::Base.transaction do
        @order.save!
        add_order_item
      end
    rescue ActiveRecord::RecordInvalid
      return false
    end
    destroy_cart
    @order.send_confirmation_email @current_user
    true
  end

  private

  def destroy_cart
    @current_cart.destroy
  end

  def add_order_item
    @current_cart.products.each do |product|
      order_detail = @order.order_details.build product_id: product.id,
        quantity: (@current_cart.quantity product), price: product.price
      order_detail.save!
    end
  end
end
