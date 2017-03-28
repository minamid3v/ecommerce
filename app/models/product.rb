class Product < ApplicationRecord
  belongs_to :sub_category
  belongs_to :classification
  has_many :order_details, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy

  mount_uploader :image, ProductUploader
  validates :name, presence: true, length: {maximum: Settings.validation.name}
  validates :description, presence: true,
    length: {maximum: Settings.validation.content}
  validates :price, presence: true,
    numericality: {greater_than_or_equal_to: Settings.validation.price}
  validates :quantity, presence: true, numericality: {only_integer: true}
  validates :sub_category_id, presence: true
  validates :classification_id, presence: true
  validates :image, presence: true

  scope :by_sub_category, ->sub_category_id do
    where sub_category_id: sub_category_id if sub_category_id.present?
  end

  scope :by_name, ->name do
    where "name LIKE '%#{name}%'" if name.present?
  end

  scope :by_min_price, ->min do
    where "price >= #{min}" if min.present?
  end

  scope :by_max_price, ->max do
    where "price <= #{max}" if max.present?
  end

  scope :by_classification, ->classification_id do
    where classification_id: classification_id if classification_id.present?
  end

  scope :top_order_products, -> {
    left_outer_joins(:order_details)
    .group("products.id")
    .order("count(order_details.id) desc")}

  scope :top_new_products, -> {order "created_at desc"}

  def self.import? file
    begin
      ActiveRecord::Base.transaction do
        CSV.foreach(file.path, headers: true) do |row|
          product = Product.new row.to_h
          product.image = open "public/uploads/product/image/1/#{row.to_h["image"]}"
          product.save!
        end
      end
    rescue ActiveRecord::RecordInvalid
      return false
    end
    true
  end

  def average_rate
    ((ratings.to_a.sum {|item| item.point}).to_f/ratings.count).
      round((Settings.average_rate_round))
  end

  def get_rating_by_user user
    rating = ratings.find_by user: user
    rating.present? ? rating.point : nil
  end

  def rate_count
    ratings.count
  end

  def is_out_of_stock? order_quantity
    quantity < order_quantity
  end

end
