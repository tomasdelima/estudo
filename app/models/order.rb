class Order < ActiveRecord::Base
  belongs_to :user
  has_many :orders_products, dependent: :destroy
  validates :orders_products,
    length: {minimum: 1, message: 'You must have at least one product in your Cart to buy it'}
  validates :user_id, presence: {message: 'You must be logged in to buy a Cart'}

  def self.check (user, cart_id)
    cart = Cart.find cart_id
    order = Order.new
    order.user_id = user.id if user
    if !cart.carts_products.empty?
      cart.carts_products.each do |carts_product|
        q = carts_product.quantity
        order.orders_products.build( product_id: carts_product.product_id, quantity: q ) if q and q > 0
      end
      cart.destroy if order.save #.valid?
    end
    # order.save
    return order
  end
end