class AddIdToOrdersProducts < ActiveRecord::Migration
  def change
    add_column :orders_products, :id, :primary_key
  end
end
