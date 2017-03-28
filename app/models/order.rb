class Order < ApplicationRecord
  attr_accessor :confirmation_token
  belongs_to :user
  belongs_to :order_status

  has_many :order_details, dependent: :destroy
  has_many :products, through: :order_details

  validates :address, presence: true,
    length: {maximum: Settings.validation.address}
  validates :full_name, presence: true,
    length: {maximum: Settings.validation.full_name}
  validates :phone, presence: true, length: {maximum: Settings.validation.phone}

  before_create :create_confirmation_digest

  scope :by_status_id, ->status_id do
    where order_status_id: status_id if status_id.present?
  end

  def order_details_count
    order_details.size
  end

  def total
    order_details.to_a.reduce(0) {|sum, item| sum + item.price*item.quantity}
  end

  def self.digest string
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
      BCrypt::Engine.cost
    BCrypt::Password.create string, cost: cost
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    if digest.nil?
      false
    else
      BCrypt::Password.new(digest).is_password? token
    end
  end

  def confirm
    update_attributes order_status_id: Settings.order.confirmed_status
  end

  def reject?
    begin
      ActiveRecord::Base.transaction do
        order_details.each do |order_detail|
          product = order_detail.product
          product.update_attributes! quantity: product.quantity + order_detail.quantity
          destroy!
        end
      end
    rescue ActiveRecord::RecordNotSaved, ActiveRecord::RecordNotDestroyed
      return false
    end
    true
  end

  def ship?
    update_attributes order_status_id: Settings.order.shipping_status
  end

  def send_confirmation_email user
    OrderMailer.order_confirmation(user, self).deliver_now
  end

  private

  def create_confirmation_digest
    self.confirmation_token = Order.new_token
    self.confirmation_digest = Order.digest confirmation_token
  end
end
