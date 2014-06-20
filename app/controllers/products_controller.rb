class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all.as_json

    @products.map { |product|
      product['quantity'] = current_user.cart.carts_products.find_by(product_id: product['id']).try(:quantity)
      product['total'] = product['quantity'].to_i * product['price'].to_f
    }


    respond_to do |format|
      format.html
      format.json { render json: @products }
    end
  end

  def new
    @product = Product.new
    if (current_user and current_user.admin == false) or !current_user
      flash[:notice] = "You must be logged as admin to enter this page"
      redirect_to root_path
    end
  end

  def create
    @product = Product.new (product_params)
    if @product.save
      flash[:notice] = "Product created successfully"
    end
    redirect_to root_path
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :price, :description)
  end
end
