class CartsController < ApplicationController
  before_action :set_cart, except: [:buy, :cart_params]

  def edit
  end

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


  def set_cart
    @cart = Cart.find(session[:cart_id])
    @carts_products = @cart.carts_products
    @sum = 0
    @carts_products.each { |cp| @sum += cp.quantity }
  end

  def remove_product
    @carts_products.where( product_id: params[:id]).destroy_all
    redirect_to cart_path(session[:cart_id])
  end

  def cart_params
    params.require(:cart).permit(:cart_id, product_ids: [])
  end

  def minus_quantity
    @carts_product = CartsProduct.find_by(cart_id: session[:cart_id], product_id: params[:id])
    @carts_product.quantity -= 1 if @carts_product.quantity > 0
    @carts_product.quantity = 0 if @carts_product.quantity < 0
    @carts_product.save
    render json: @carts_product.quantity
  end

  def plus_quantity
    @carts_product = CartsProduct.find_by(cart_id: session[:cart_id], product_id: params[:id])
    if !@carts_product
      @carts_product = CartsProduct.create cart_id: session[:cart_id],
        product_id: Product.find(params[:id]).id, quantity: 1
    else
      @carts_product.quantity += 1
      @carts_product.save
    end
    render json: @carts_product.quantity
  end
end
