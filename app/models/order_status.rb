class OrderStatus < ApplicationRecord
  has_many :orders

  validates :name, presence: true, length: {maximum: Settings.validation.name}
  validates :description, presence: true,
    length: {maximum: Settings.validation.description}
end
