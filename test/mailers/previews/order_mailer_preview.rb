# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/order_mailer/order_confirmation
  def order_confirmation
    user = User.find(12)
    order = Order.find(19)
    OrderMailer.order_confirmation user, order
  end

end
