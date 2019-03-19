class RemoveOrdersDateFromOrders < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :orders_date, :datetime
  end
end
