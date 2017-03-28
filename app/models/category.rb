class Category < ApplicationRecord
  has_many :sub_categories, dependent: :destroy

  validates :name, presence: true, length: {maximum: Settings.validation.name}
  validates :description, presence: true,
    length: {maximum: Settings.validation.content}

  def sub_category_select
    sub_categories.map{|sub_category| [sub_category.name, sub_category.id]}
  end
end
