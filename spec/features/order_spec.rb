require 'spec_helper'


describe "After a transaction there", js: true do
  let!(:product) { FactoryGirl.create :product }
  let!(:user)    { FactoryGirl.create :user }

  before :each do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: '12345678'
    click_on 'Sign in'
    visit products_path
  end

  it 'should be an order saved' do
    click_on '+'
    click_on 'Buy this Cart'
    page.driver.browser.switch_to.alert.accept
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

describe "Users should be ", js: true do
  let!(:user)    { FactoryGirl.create :user }
  let!(:product) { FactoryGirl.create :product }
  let!(:order)   { FactoryGirl.create(:order, user: user) }

  before do
    order.products << product
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: '12345678'
    click_on 'Sign in'
    visit root_path
  end

  it "able to view one's orders" do
    click_on 'View my Orders'
    expect(page).to have_content 'Listing all Orders'
    within("#orders") { expect(page).to have_content order.id }
    visit order_path user, order
    expect(page).to have_content 'Details of Order'
    within("#order") { expect(page).to have_content order.id }
    within("#products") { expect(page).to have_content product.name }
    within("#products") { expect(page).to have_content OrdersProduct.find_by(order: order, product: product).quantity }
  end

  it "unable to view all orders" do
    visit all_orders_path
    expect(page).to have_content 'You must be Admin to access this page'
    click_on 'Logout'
    visit all_orders_path
    expect(page).to have_content 'You must be Admin to access this page'
  end
end

describe "Admins should be ", js: true do
  let!(:admin)   { FactoryGirl.create :admin }
  let!(:product) { FactoryGirl.create :product }
  let!(:order)   { FactoryGirl.create(:order, user: admin) }

  before do
    visit new_user_session_path
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: '87654321'
    click_on 'Sign in'
  end

  it "able to view one's orders" do
    visit orders_path admin
    expect(page).to have_content 'Listing all Orders'
    within("#orders") { expect(page).to have_content order.id }
  end

  it "able to view all orders" do
    visit all_orders_path
    expect(page).not_to have_content 'You must be Admin to access this page'
    within("#all_orders") { expect(page).to have_content order.id }
  end
end

describe "Orders status:", js: true do
  let!(:admin)   { FactoryGirl.create :admin }
  let!(:user)    { FactoryGirl.create :user }
  let!(:product) { FactoryGirl.create :product }
  let!(:order)   { FactoryGirl.create(:order, user: user) }

  it "Admins are able to set to 'Awaiting shipment' and 'Shipped'" do
    visit new_user_session_path
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: '87654321'
    click_on 'Sign in'
    visit order_path( user, order)
    within("#status-line") { expect(page).to have_selector 'button' }
    # debugger
    click_on "Change to 'Awaiting shipment'"
    within("#status-line") { expect(page).to have_selector 'button' }
    # debugger
    click_on "Change to 'Shipped'"
    within("#status-line") { expect(page).not_to have_selector 'button' }
  end

  it "Users are able only to set to 'Received'" do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: '12345678'
    click_on 'Sign in'
    visit order_path( user, order)
    within("#status-line") { expect(page).not_to have_selector 'button' }
    order.status = 'Shipped'
    order.save
    visit order_path( user, order)
    within("#status-line") { expect(page).to have_selector 'button' }
  end
end
