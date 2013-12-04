require 'spec_helper'

describe 'Under /products there' do
  before :each do
    FactoryGirl.create(:product)
    FactoryGirl.create(:product, name: 'Test Product 2')
    visit '/products'
  end

  it 'should redirect to /products' do
    visit '/'
    expect(page).to have_content('Listing all products')
  end

  it 'should list all products' do
    expect(page).to have_content('Test Product')
    expect(page).to have_content('Test Product 2')
  end

  it 'should have a link to view each product' do
    Product.last.destroy
    visit '/products'
    click_on('View Product')
    expect(current_path).to eq('/products/1')
  end

  it 'should have a link to add each product to cart' do
    click_on('Add products to Cart')
    expect(current_path).to eq('/carts/1/edit')
    check 'cart_product_ids_1'
    check 'cart_product_ids_2'
    click_on 'Update Cart'
    Cart.first.products.size.should eq 2
  end

  it 'should be a link to view the cart' do
    click_on 'View the Cart'
    expect(current_path).to eq('/carts/1')
  end
end

describe 'Under /products/new there' do
  before :each do
    @admin = FactoryGirl.create(:user, admin: true, name: 'Admin User', email: 'admin.user@email.com', password: '87654321')
    visit '/'
    click_on 'Login'
    fill_in 'Email', with: @admin.email
    fill_in 'Password', with: @admin.password
    click_on 'Sign in'
    visit '/products/new'
  end

  it 'should be a Name, Price and Description fields' do
    page.should have_field('Name')
    page.should have_field('Price')
    page.should have_field('Description')
  end

  it 'shloud be a Create Product button' do
    fill_in 'Name', with: 'Test Product'
    fill_in 'Price', with: '9.90'
    click_on 'Create Product'
    current_path.should eq('/')
    Product.first.should_not be_nil
  end

  it 'shloud be a Back button' do
    click_on 'Back'
    current_path.should eq('/products')
    Product.first.should be_nil
  end
end

