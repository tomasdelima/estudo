class Order < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :products
  validates :user_id, presence: {message: 'You must be logged in to buy a Cart'}
  validates :product_ids, length: {minimum: 1, message: 'You must have at least one product in your Cart to buy it'}

  def self.check (user, cart_id)
    @order = Order.new
    if user
      @cart = Cart.find(cart_id)
      @order.user_id = user.id
      @order.product_ids = @cart.product_ids
      @order.save
      @cart.destroy if @order.valid?
    end
    return @order
  end
end