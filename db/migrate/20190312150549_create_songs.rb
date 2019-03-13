class CreateSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :songs do |t|
      t.string :song_title
      t.integer :artist_id
      t.integer :track_order
      t.integer :product_id
      t.integer :disk_number

      t.timestamps
    end
  end
end
