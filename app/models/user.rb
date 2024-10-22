class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # has_many :orders, dependent: :destroy
  #
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  

  has_one :wishlist
  has_many :wishlist_items, through: :wishlist
  has_many :wishlisted_products, through: :wishlist_items, source: :product
  has_many :reviews, dependent: :destroy
  # has_many :order_items, through: :orders
  has_one :cart, dependent: :destroy
  has_one :wishlist, dependent: :destroy
  has_many :orders, dependent: :destroy


  private

  def initialize_cart
    create_cart
  end

  def empty?
    cart_items.empty?
  end

end
