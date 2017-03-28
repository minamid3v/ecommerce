class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.references :sub_category, foreign_key: true
      t.references :classification, foreign_key: true
      t.text :description
      t.float :price
      t.string :image
      t.integer :quantity

      t.timestamps
    end
  end
end
