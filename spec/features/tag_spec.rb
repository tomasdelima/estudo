require 'spec_helper'

describe 'Under /products/:id there', js: true do
  let!(:product)  { FactoryGirl.create :product }
  let!(:user)     { FactoryGirl.create :user }
  let!(:admin)    { FactoryGirl.create :admin }
  let!(:tag)      { FactoryGirl.create :tag }
  let(:tag1)      { FactoryGirl.create :tag }
  let(:tag2)      { FactoryGirl.create :tag }
  before do
    tag.products << product
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: '12345678'
    click_on 'Sign in'
    visit product_path product
  end


  it 'should be able to add many Tags to a Product' do
    click_on "Logout"
    visit new_user_session_path
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: '87654321'
    click_on 'Sign in'

    visit product_path product
    fill_in 'TagName', with: tag1.name
    click_on 'Add Tag'
    sleep 1
    fill_in 'TagName', with: tag2.name
    click_on 'Add Tag'
    sleep 1
    within("#AllTags") { expect(page).to have_content(tag1.name) }
    within("#AllTags") { expect(page).to have_content(tag2.name) }
  end

  it 'normal users should not be able to add tags' do
    expect(all("#AddTag").size).to eq 0
  end

  it 'should list all tags' do
    within("#AllTags") { expect(page).to have_content tag.name }
  end

  it 'clicking a Tag should redirect to that tag show path' do
    visit current_path
    click_on tag.name
    expect(current_path).to eq tag_path tag.id
    expect(page).to have_content product.name
  end

  it 'should be able to delete a tag if Admin' do
    click_on tag.name
    expect(page).not_to have_content 'Delete'

    click_on "Logout"
    visit new_user_session_path
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: '87654321'
    click_on 'Sign in'
    visit tag_path tag
    expect(page).to have_content 'Delete'

  end
end
