# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    user
    status 'Awaiting payment'
    after(:build) { |order| order.orders_products << FactoryGirl.build(:orders_product, order: order) }
  end
end
