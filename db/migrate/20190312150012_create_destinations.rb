class CreateDestinations < ActiveRecord::Migration[5.2]
  def change
    create_table :destinations do |t|
      t.string :destination_name
      t.string :destination_postcode
      t.text :destination_address
      t.integer :user_id

      t.timestamps
    end
  end
end
