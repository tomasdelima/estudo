# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tag do
    # product { FactoryGirl.create :product }
    name    { "Tag " + rand(100).to_s }
  end
end
