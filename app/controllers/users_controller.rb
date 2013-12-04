class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # admin = false

  # def index
  #   @users = User.all
  # end

  # def new
  #   @user = User.new
  # end

  # def create
  #   @user = User.new (user_params)
  #   @user.save
  # end

  # def set_user
  #   @user = User.find(params[:id])
  # end

  # def user_params
  #   params.require(:user).permit(:name, :email)
  # end

  # def login
  #   @user = User.new
  # end

  # def logged_in
  #   @user = User.where(name: params[:user][:name]).first
  #   if @user
  #     flash[:notice] = 'You logged in'
  #     session[:user_id] = @user.id
  #     Cart.last.user_id = session[:user_id]
  #     redirect_to user_path(@user.id)
  #   else
  #     redirect_to login_path
  #   end
  # end

  # def logout
  #   flash[:logout] = 'You logged out'
  #   session[:user_id] = nil
  #   redirect_to products_path
  # end
end
