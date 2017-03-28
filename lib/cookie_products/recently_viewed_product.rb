class RecentlyViewedProduct < CookieCollection
  def initialize cookies
    super cookies
    self.ids = ids.last Settings.recently_viewed.size
    ids.each {|product_id| push Product.find_by(id: product_id)}
  end

  def push product
    if product.present?
      delete product
      while length > Settings.recently_viewed.size - 1
        delete_at 0
      end
      super product
    end
  end
end
