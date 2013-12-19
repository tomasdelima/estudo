class Users::RegistrationsController < Devise::RegistrationsController
  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end


  def create
    build_resource(sign_up_params)
    if resource.save
      @user.cart_id = Cart.create(user_id: @user.id).id
      @user.save
      session[:cart_id] = @user.cart_id
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      # else
      #   set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
      #   expire_data_after_sign_in!
      #   respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end


  private :sign_up_params
end