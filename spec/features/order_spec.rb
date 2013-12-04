require 'spec_helper'

describe "After a transaction there" do
  before :each do
    @product = FactoryGirl.create(:product)
    @user = FactoryGirl.create :user
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: '12345678'
    click_on 'Sign in'
    visit '/carts/'+Cart.last.id.to_s+'/edit'
    check 'cart_product_ids_1'
    click_on 'Update Cart'
    click_on 'Buy this Cart'
    @order = Order.last
  end

  it "should be no products in the Carts" do
    Cart.last.products.size.should eq 0
  end

  it 'should redirect to /products' do
    expect(current_path).to eq '/products'
  end
end




describe "Should not be able to buy a Cart" do
  before :each do
    @product = FactoryGirl.create(:product)
    @user = FactoryGirl.create :user
    visit products_path
    @cart = Cart.last
  end

  it "without products on the order" do
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: '12345678'
    click_on 'Sign in'
    visit cart_path @cart.id
    click_on 'Buy this Cart'
    expect(page).to have_content 'You must have at least one product in your Cart to buy it'
  end

  it 'not logged in' do
    visit '/carts/'+Cart.last.id.to_s+'/edit'
    check 'cart_product_ids_1'
    click_on 'Update Cart'
    visit cart_path @cart.id
    click_on 'Buy this Cart'
    expect(page).to have_content 'You must be logged in to buy a Cart'
    current_path.should eq new_user_session_path
  end
end
