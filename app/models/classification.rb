class Classification < ApplicationRecord
  has_many :products, dependent: :destroy
  
  validates :name, presence: true, length: {maximum: Settings.validation.name}
  validates :description, presence: true,
    length: {maximum: Settings.validation.description}
end
