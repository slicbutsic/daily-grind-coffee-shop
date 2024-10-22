class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def add_product(product)
    current_item = cart_items.find_by(product: product)
    if current_item
      current_item.increment!(:quantity)
    else
      current_item = cart_items.create(product: product, quantity: 1)
    end
    current_item
  end

  def total_price
    cart_items.sum { |item| item.quantity * item.product.price }
  end

  def product_in_cart?(product)
    cart_items.exists?(product: product)
  end

  def total_items
    cart_items.sum(:quantity)
  end
end
