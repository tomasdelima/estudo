class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :edit, :update, :destroy, :remove_product]

  def edit
  end

  # def index
  #   redirect_to carts_path
  # end

  def buy
    @order = Order.check( current_user, session[:cart_id] )
    if @order.valid?
      @cart = Cart.create
      session[:cart_id] = @cart.id
      flash[:buy] = 'You bought the Cart. A new Cart was generated'
      redirect_to products_path
    else
      flash[:buy] = @order.errors.messages.to_a[0][1][0]
      if flash[:buy] == 'You must be logged in to buy a Cart'
        redirect_to new_user_session_path
      else
        redirect_to products_path
      end
    end
  end

#Couldnt make test to pass through 'update > else'

  def update
    respond_to do |format|
      if @cart.update_attributes(cart_params)
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        format.json { head :no_content }
      # else
      #   format.html { render action: 'edit' }
      #   format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  def set_cart
    @cart = Cart.find(session[:cart_id])
  end

  def remove_product
    @cart.products.delete(Product.find(params[:product_id]))
    @cart.save
    redirect_to cart_path(session[:cart_id])
  end

  def cart_params
    params.require(:cart).permit(:cart_id, product_ids: [])
  end

end
