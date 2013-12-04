require 'spec_helper'

describe 'Under /carts/:id' do
  before do
    Cart.destroy_all
    @product = FactoryGirl.create(:product)
    @user = FactoryGirl.create :user
    visit '/carts/1'
    @cart = Cart.find(1)
    @cart.product_ids = [1]
    visit '/carts/1'
  end

  it 'should list all products' do
    page.should have_content('Test Product')
    1
  end

  it 'should be a link to remove each product' do
    click_on 'Remove Product'
    visit '/carts/1'
    expect(Cart.find(1).products.size).to eq(0)
  end

  it 'should be a link to add new products' do
    click_on 'Add Products'
    click_on 'Update Cart'
    expect(@cart.products.size).to eq(1)
  end

  it 'should be a link to buy the Cart' do
    visit cart_path(1)
    click_on 'Buy this Cart'
  end

end