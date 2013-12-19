class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :cart
  has_many :orders
  validates :name, uniqueness: true, presence: true

  def abandon_saved_cart new_cart_id
    self.cart.destroy
    self.cart_id = new_cart_id
    self.save
  end

end
