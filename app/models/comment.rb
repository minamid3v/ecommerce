class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :product_id, presence: true
  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.validation.content}
end
