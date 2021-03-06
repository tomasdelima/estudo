require 'spec_helper'

describe User do
  describe '.abandon_saved_cart' do
    let!(:user) { FactoryGirl.create :user }
    let!(:cart1) { Cart.find user.cart_id }
    let!(:cart2) { FactoryGirl.create :cart }

    it 'should destroy Cart at DB' do
      user.abandon_saved_cart cart2.id
      expect(user.cart_id).to eq cart2.id
    end

    it 'should save current Cart at DB' do
      user.abandon_saved_cart cart2.id
      expect(User.find(user.id).cart_id).to eq cart2.id
    end
  end
end
