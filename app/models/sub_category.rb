class SubCategory < ApplicationRecord
  belongs_to :category
  
  has_many :products, dependent: :destroy

  validates :name, presence: true, length: {maximum: Settings.validation.name}
  validates :description, presence: true,
    length: {maximum: Settings.validation.description}
  validates :category_id, presence: true

  def sub_category_select
    sub_categories.map{|sub_category| [sub_category.name, sub_category.id]}
  end
end
