require 'spec_helper'

describe Order do
  describe '.check' do

    let!(:user) { FactoryGirl.create :user }
    let!(:product) { FactoryGirl.create :product }

    it "should return invalid order if not logged in" do
      Order.check( nil, user.cart_id ).valid?.should be false
    end

    it "should return invalid order if Cart is empty" do
      Order.check( @user, user.cart_id ).valid?.should be false
    end

    it "should return valid order if transaction works" do
      @carts_product = FactoryGirl.create :carts_product, cart_id: user.cart_id, product_id: product.id
      expect( Order.check( user, user.cart_id ) ).to eq Order.first
    end
  end
end