class CreateSubCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :sub_categories do |t|
      t.references :category, foreign_key: true
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
