class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def import_cart
    Cart.destroy session[:cart_id]
    session[:cart_id] = current_user.cart_id
    redirect_to root_path
  end

  def import
  end

  def dont_import_cart
    current_user.abandon_saved_cart session[:cart_id]
    redirect_to root_path
  end

end
