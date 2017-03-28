class SessionCart
  attr_accessor :session
  attr_accessor :products

  def initialize session
    self.session = session
    session[:current_cart] ||= {}
  end

  def add product, quantity
    session[:current_cart][product.id.to_s] ||= 0
    session[:current_cart][product.id.to_s] += quantity.to_i
  end

  def remove product
    session[:current_cart].tap do |current_cart|
      current_cart.delete product.id.to_s
    end
  end

  def size
    session[:current_cart].values.reduce(:+)
  end

  def quantity product
    session[:current_cart][product.id.to_s]
  end

  def products
    self.products = session[:current_cart].keys.map do |product_id|
      Product.find_by id: product_id.to_i
    end
  end

  def product_count
    products.size
  end

  def total
    session[:current_cart].sum do |product_id, quantity|
      Product.find_by(id: product_id.to_i).price * quantity.to_i
    end
  end

  def destroy
    products.each do |product|
      product.update_attributes(quantity: product.quantity + quantity(product))
    end
    session[:current_cart] = nil
  end

  def checkout
    session[:current_cart] = nil
  end
end
