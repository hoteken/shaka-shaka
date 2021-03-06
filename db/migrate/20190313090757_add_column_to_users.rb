class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :user_name, :string
    add_column :users, :user_name_kana, :string
    add_column :users, :postcode, :string
    add_column :users, :address, :string
    add_column :users, :phone_number, :string
  end
end
