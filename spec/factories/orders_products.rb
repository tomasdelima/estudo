
FactoryGirl.define do
  factory :orders_product do
    product
    order
    quantity { rand(100) }
  end
end
