require 'spec_helper'

describe 'Under /carts/:id', js: true do
  let(:cart)     { FactoryGirl.create :cart }
  let(:user)     { FactoryGirl.create :user, cart: cart }
  let!(:product) { FactoryGirl.create :product }

  before do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: '12345678'
    click_on 'Sign in'
    visit products_path
    click_on '+'
    visit cart_path user.cart_id
  end

  it 'should list all products' do
    page.should have_content('Test Product')
  end

  it 'should be a link to remove each product' do
    click_on 'Remove Product'
    page.driver.browser.switch_to.alert.accept
    within('#total') { expect(page).to have_content '0' }
  end

  it 'should be a link to add new products' do
    click_on 'Add Products'
    expect(current_path).to eq products_path
  end

  it 'should be a link to buy the Cart' do
    expect(page).to have_content 'Buy this Cart'
  end

end