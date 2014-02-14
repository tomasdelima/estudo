class Users::SessionsController < Devise::SessionsController
  before_action :set_user # , only: [:show, :edit, :update, :destroy]

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) #if is_navigation_format?
    sign_in(resource_name, resource)
    @cart = Cart.find(session[:cart_id])
    # @cart.user_id = current_user.id
    # @cart.save
    # debugger
    if @cart.carts_products.empty?
      redirect_to import_cart_path
    else
      # respond_with resource, :location => after_sign_in_path_for(resource)
      redirect_to import_path
    end
  end

  def set_user
    # debugger
    @user = User.find(session[:user_id]) if session[:user_id]
  end
end