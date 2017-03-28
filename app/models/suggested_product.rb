class SuggestedProduct < ApplicationRecord
  belongs_to :user

  mount_uploader :image, ProductUploader

  validates :name, presence: true, length: {maximum: Settings.validation.name}
  validates :price, presence: true,
    numericality: {greater_than_or_equal_to: Settings.validation.price}
  validates :content, presence: true,
    length: {maximum: Settings.validation.content}
  validates :image, presence: true

  scope :by_name_description, ->keyword do
    where "name LIKE '%#{keyword}%' OR content LIKE '%#{keyword}%'" if keyword.present?
  end

  scope :by_min_price, ->min do
    where "price >= #{min}" if min.present?
  end

  scope :by_max_price, ->max do
    where "price <= #{max}" if max.present?
  end
end
