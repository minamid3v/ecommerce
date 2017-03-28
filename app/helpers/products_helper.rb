module ProductsHelper

  def recently_viewed_products
    @recently_viewed_products ||= RecentlyViewedProduct.new(cookies)
  end
end
