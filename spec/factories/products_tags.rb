# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory   :products_tag do
    tag     { FactoryGirl.create :tag }
    product { FactoryGirl.create :product }
  end
end
