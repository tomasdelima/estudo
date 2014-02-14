class AddIdAndQuantityToCartsProducts < ActiveRecord::Migration
  def change
    add_column :carts_products, :id, :primary_key
    add_column :carts_products, :quantity, :integer
  end
end
