require 'spec_helper'

describe 'Function check should' do
  before :each do
    @user = FactoryGirl.create :user
    @product = FactoryGirl.create :product
    @cart = Cart.create
  end

  it "return invalid order if not logged in" do
    @cart.product_ids = [@product.id]
    Order.check( nil, @cart.id ).valid?.should be false
  end

  it "return invalid order if Cart is empty" do
    Order.check( @user, @cart.id ).valid?.should be false
  end

  it "return valid order if transaction works" do
    @cart.product_ids = [@product.id]
    expect( Order.check( @user, @cart.id ) ).to eq Order.first
  end
end
