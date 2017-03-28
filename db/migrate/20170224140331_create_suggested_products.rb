class CreateSuggestedProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :suggested_products do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.float :price
      t.string :image
      t.text :content

      t.timestamps
    end
  end
end
