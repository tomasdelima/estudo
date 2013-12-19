class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all
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
