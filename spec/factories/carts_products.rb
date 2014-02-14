# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :carts_product do
    cart
    product
    quantity 1
  end
end
