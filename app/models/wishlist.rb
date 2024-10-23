class Wishlist < ApplicationRecord
  belongs_to :user
  has_many :wishlist_items
  has_many :products, through: :wishlist_items

  def toggle_product(product)
    wishlist_item = wishlist_items.find_by(product: product)

    if wishlist_item
      wishlist_item.destroy
      false
    else
      wishlist_items.create(product: product)
      true
    end
  end

  def remove_product(product)
    wishlist_items.find_by(product: product)&.destroy
  end
end
