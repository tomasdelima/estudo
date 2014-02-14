FactoryGirl.define do
  # factory :admin, :class User do
  Admin = User
  factory :admin do
    name      { 'Admin User' + rand(1000).to_s }
    email     { 'admin.user' + rand(1000).to_s + '@email.com' }
    password  '87654321'
    admin     true
    cart_id   { FactoryGirl.create(:cart).id }
  end
end