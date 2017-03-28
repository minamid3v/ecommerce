module CartsHelper

  def current_cart
    @current_cart || SessionCart.new(session)
  end
end
