class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :product_title
      t.integer :product_price
      t.integer :label_id
      t.integer :genre_id
      t.text :explanation
      t.string :image_id
      t.integer :stock

      t.timestamps
    end
  end
end
