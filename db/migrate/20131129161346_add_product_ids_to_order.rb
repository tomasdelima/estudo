class AddProductIdsToOrder < ActiveRecord::Migration
  def change
    create_table :orders_products, :id => false do |t|
      t.references :order, index: true
      t.references :product, index: true
    end
#    add_reference :orders, :product_id, index: true
  end
end
