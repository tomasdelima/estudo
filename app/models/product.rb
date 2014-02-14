class Product < ActiveRecord::Base
  has_and_belongs_to_many :tags
  has_many :carts_products
  has_many :carts, through: :carts_products
  has_many :orders_products
  has_many :orders, through: :orders_products
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true
end
