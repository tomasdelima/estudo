class CreateProductsTags < ActiveRecord::Migration
  def change
    create_table :products_tags do |t|
      t.references :tag, index: true
      t.references :product, index: true
    end
  end
end
