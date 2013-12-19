class Cart < ActiveRecord::Base
  has_one :user
  has_many :carts_products, dependent: :destroy

end
