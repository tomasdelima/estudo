class CreateTagsProducts < ActiveRecord::Migration
  def change
    create_table :tags_products do |t|
      t.references :product, index: true
      t.references :tag, index: true
    end
  end
end
