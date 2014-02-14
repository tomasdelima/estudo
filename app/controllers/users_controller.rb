class UsersController < ApplicationController
  # before_action :set_user, only: [:show, :edit, :update, :destroy]

  def import_cart
    # Will destroy current Cart and load saved Cart
    Cart.destroy session[:cart_id]
    session[:cart_id] = current_user.cart_id
    redirect_to root_path
  end

  def import
    # debugger
  end

  def dont_import_cart
    # Will destroy saved Cart and save current Cart to User
    current_user.abandon_saved_cart session[:cart_id]
    redirect_to root_path
  end

end
