class StaticPagesController < ApplicationController
  
  def home
    @hot_trends = Product.top_order_products
    @new_products = Product.top_new_products.paginate page: params[:page],
      per_page: Settings.paginate.top_new_products
  end
end
