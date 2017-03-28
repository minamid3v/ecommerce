class CreateRatings < ActiveRecord::Migration[5.0]
  def change
    create_table :ratings do |t|
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true
      t.float :point

      t.timestamps
    end
  end
end
