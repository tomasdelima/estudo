require 'spec_helper'

describe 'Under /users/sign_up/in' do
  let(:user)    {FactoryGirl.create :user}
  before { visit products_path }

  it 'should display a message at unsuccessfull login' do
    visit new_user_session_path
    fill_in 'Email', with: 'wrong@user'
    fill_in 'Password', with: 'wrongpassword'
    click_button 'Sign in'
    expect(page).to have_content 'Invalid email or password.'
  end

  it 'should display a message at unsuccessfull sign up' do
    click_on 'Sign up'
    fill_in 'Name', with: user.name
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password+'2'
    click_button 'Sign up'
    expect(page).to have_content "Email has already been takenPassword confirmation doesn't match PasswordName has already been taken"
  end
end

describe 'Admins:' do
  let(:user)    {FactoryGirl.create :user}
  let(:admin)   {FactoryGirl.create :admin}
  before { visit products_path }

  it 'admin users should be able to create new products' do
    visit new_user_session_path
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_on 'Sign in'
    visit new_product_path
    fill_in 'Name', with: 'Test Product'
    fill_in 'Price', with: '9.90'
    click_on 'Create Product'
    expect(page).to have_content 'Product created successfully'
  end

  it 'normal users should not be able to create new products' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Sign in'
    visit new_product_path
    expect(page).to have_content "You must be logged as admin to enter this page"
    current_path.should eq '/'
    Product.all.size.should be 0
  end
end


describe 'At login', js: true do
  let!(:old_user_cart) {FactoryGirl.create :cart}
  let!(:user)          {FactoryGirl.create :user, cart_id: old_user_cart.id}
  let!(:product)       {FactoryGirl.create :product}

  it 'should be able to import last Cart if actual Cart is filled' do
    visit root_path
    click_on '+'
    no_user_cart = Cart.last
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Sign in'
    click_on 'Import'
    expect(user.cart).to eq old_user_cart
    expect(user.cart).not_to eq no_user_cart
  end

  it 'should be able to keep current Cart if actual Cart is filled' do
    visit root_path
    click_on '+'
    no_user_cart = Cart.last
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Sign in'
    click_on "Don't import"
    user = User.last if User.last == User.first
    expect(user.cart).to eq no_user_cart
  end

  it 'should import last Cart if actual Cart is empty' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Sign in'
    expect(current_path).to eq root_path
  end
end




