class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.references :order_status, foreign_key: true
      t.string :address
      t.string :full_name
      t.string :phone

      t.timestamps
    end
  end
end
