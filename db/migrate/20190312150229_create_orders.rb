class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.datetime :orders_date
      t.integer :status
      t.string :destination_name
      t.string :destination_postcode
      t.text :destination_address
      t.integer :product_id
      t.integer :quantity
      t.integer :total_price

      t.timestamps
    end
  end
end
