FactoryGirl.define do
  factory :product do
    name { 'Test Product' + rand(1000).to_s }
    price { rand(100) }
  end
end