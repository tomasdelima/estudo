require 'spec_helper'


describe "After a transaction there", js: true do
  let!(:product) { FactoryGirl.create :product }
  let!(:user)    { FactoryGirl.create :user }

  before :each do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: '12345678'
    # product
    visit products_path
  end

  it 'should be an order saved' do
    click_on '+'
    click_on 'Buy this Cart'
    page.driver.browser.switch_to.alert.accept
    debugger
    # click_on '+'
    # click_on 'Buy this Cart'
    # page.driver.browser.switch_to.alert.accept
    visit root_path
    Order.count.should eq 1
  end

  it "should be no products in the Carts" do
    page.all('button.mp')[1].click
    click_on 'Buy this Cart'
    page.driver.browser.switch_to.alert.accept
    visit current_path
    CartsProduct.where(cart_id: user.cart.id).size.should eq 0
  end

  it 'should redirect to /products' do
    expect(current_path).to eq '/products'
  end
end


describe "Should not be able to buy a Cart", js: true do
  let!(:user) { FactoryGirl.create :user }
  let!(:product) { FactoryGirl.create(:product) }

  before :each do
    visit products_path
  end

  it "without products on the order" do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: '12345678'
    click_on 'Sign in'
    visit products_path
    click_on 'Buy this Cart'
    page.driver.browser.switch_to.alert.accept
    click_on 'Buy this Cart'
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content 'You must have at least one product in your Cart to buy it'
  end

  it 'not logged in' do
    visit products_path
    click_on '+'
    click_on 'Buy this Cart'
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content 'You must be logged in to buy a Cart'
    current_path.should eq new_user_session_path
  end
end