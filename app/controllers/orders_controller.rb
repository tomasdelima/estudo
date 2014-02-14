class OrdersController < ApplicationController
  before_action :check_visibility, only: [:change_status, :show]

  def index
    if current_user and current_user.admin
      @orders = Order.all
    else
      flash[:notice] = 'You must be Admin to access this page'
      redirect_to root_path
    end
  end

  def test_user_permission (&block)
    if current_user
      if current_user.id == params[:user_id].to_i or current_user.admin
        block.call
      else
        flash[:notice] = "You don't have permission to access this page"
        redirect_to root_path
      end
    else
      flash[:notice] = "You must login to view this page"
      redirect_to new_user_session_path
    end
  end

  def show
    test_user_permission { @order = Order.find params[:order_id] }
  end

  def list
    test_user_permission { @orders = Order.where user: current_user }
  end

  def check_visibility
    order = Order.find params[:order_id]
    # debugger
    if (current_user.admin and order.status != 'Shipped' and order.status != 'Received') or
       (current_user == order.user and order.status=='Shipped' and order.status != 'Received')
      @visible_button = true
    else
      @visible_button = false
    end
  end

  def change_status
    order = Order.find params[:order_id]
    order.status = order.get_next_status
    order.save
    check_visibility
    render json: { order_status: order.status, next_order_status: order.get_next_status, visible: @visible_button }
  end
end
