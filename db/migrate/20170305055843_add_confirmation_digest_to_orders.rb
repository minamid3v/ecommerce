class AddConfirmationDigestToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :confirmation_digest, :string
  end
end
