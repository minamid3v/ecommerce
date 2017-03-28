class OrderDetail < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :product_id, presence: true
  validates :order_id, presence: true
  validates :quantity, presence: true,
    numericality: {greater_than_or_equal_to: Settings.validation.quantity}
  validates :price, presence: true, numericality: true

  scope :number_of_product, -> do
    left_outer_joins(:product)
    .group("products.id")
    .sum(:quantity)
  end

  scope :income_of_product, -> do
    left_outer_joins(:product)
    .group("products.id")
    .sum("order_details.price * order_details.quantity")
  end

  scope :by_month, ->date do
    where "order_details.created_at >= '#{date.beginning_of_month.to_s(:db)}' AND order_details.created_at <= '#{Time.zone.now.end_of_month.to_s(:db)}'"
  end

  scope :by_year, ->date do
    where "order_details.created_at >= '#{date.beginning_of_year.to_s(:db)}' AND order_details.created_at <= '#{Time.zone.now.end_of_year.to_s(:db)}'"
  end

  scope :by_day, ->date do
    where "order_details.created_at >= '#{date.beginning_of_day.to_s(:db)}' AND order_details.created_at <= '#{Time.zone.now.end_of_day.to_s(:db)}'"
  end

  def self.number_of_product_chart_data
    self.number_of_product.transform_keys { |product_id| Product.find_by(id: product_id).name }
  end

  def self.income_of_product_chart_data
    self.income_of_product.transform_keys { |product_id| Product.find_by(id: product_id).name }
  end

  scope :income_monthy, -> {
    group_by_month(:created_at).sum("quantity * price")}

  scope :income_yearly, -> {
    group_by_year(:created_at).sum("quantity * price")}

  scope :income_daily, -> {
    group_by_day(:created_at).sum("quantity * price")}
end
