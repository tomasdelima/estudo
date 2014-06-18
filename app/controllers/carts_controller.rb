class CartsController < ApplicationController
  before_action :set_cart, except: [:buy, :cart_params]

  def edit
  end

  def buy
    @order = Order.check( current_user, session[:cart_id] )
    if @order.valid?
      @cart = Cart.create
      session[:cart_id] = @cart.id
      current_user.cart = @cart
      current_user.save
      flash[:buy] = "You bought the Cart."
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

    respond_to do |format|
      format.json { render json: carts_product_quantity.to_json }
      format.html {}
    end

  end

  def carts_product_quantity
    Product.all.map { |p|
      if CartsProduct.where(cart_id: @cart.id).map{|cp| cp.product_id}.include? p.id
        CartsProduct.find_by(cart_id: @cart.id, product_id: p.id).quantity
      else
        0
      end
    }
  end

  def products
    respond_to do |format|
      format.json { render json: CartsProduct.where(cart_id: @cart.id).to_json }
      format.html {}
    end
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
    if @carts_product
      @carts_product.quantity -= 1 if @carts_product.quantity > 0
      @carts_product.quantity = 0  if @carts_product.quantity < 0
      @carts_product.save
      render json: @carts_product.quantity
    else
      render json: {}
    end
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
