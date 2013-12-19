FactoryGirl.define do
  factory :user do
    name      { 'Test User' + rand(1000).to_s }
    email     { 'test.user' + rand(1000).to_s + '@email.com' }
    password  '12345678'
    admin     false
    cart      { FactoryGirl.create(:cart) }
  end
end
