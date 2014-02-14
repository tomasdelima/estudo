require 'spec_helper'

describe 'Under /products there', js: true do
  let!(:product1) { FactoryGirl.create(:product) }
  let(:product2) { FactoryGirl.create(:product, name: 'Test Product 2') }
  before { visit products_path }

  it 'should redirect to /products' do
    visit root_path
    expect(page).to have_content('Listing all products')
  end

  it 'should list all products' do
    name1, name2 = product1.name, product2.name
    visit products_path
    expect(page).to have_content(name1)
    expect(page).to have_content(name2)
  end

  it 'should have a link to view each product' do
    visit products_path
    click_on('View product details')
    expect(current_path).to eq(product_path product1)
  end

  it 'should have a link to add and remove each product to cart' do
    visit root_path
    click_on '+'
    click_on '+'
    sleep 1
    CartsProduct.count.should eq 1
    CartsProduct.first.quantity.should eq 2
    click_on '-'
    sleep 1
    CartsProduct.first.quantity.should eq 1
  end

  it 'should be a link to view the cart' do
    click_on '+'
    click_on 'View the Cart'
    expect(current_path).to eq(cart_path 1)
    expect(page).to have_content product1.name
  end
end

describe 'Under /products/new there' do
  let!(:admin) { FactoryGirl.create :admin }

  before :each do
    visit root_path
    click_on 'Login'
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_on 'Sign in'
    visit new_product_path
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
    current_path.should eq(root_path)
    Product.first.should_not be_nil
  end

  it 'shloud be a Back button' do
    click_on 'Back'
    current_path.should eq(products_path)
  end
end

describe 'Under /products/:id there' do
  let!(:admin) { FactoryGirl.create :admin }
  let!(:product) { FactoryGirl.create :product }

  before :each do
    visit root_path
    click_on 'Login'
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_on 'Sign in'
    visit product_path product
  end

  it 'should show Name, Price and Description' do
    expect(page).to have_content(product.name)
    expect(page).to have_content(product.price)
    expect(page).to have_content(product.description)
  end
end

