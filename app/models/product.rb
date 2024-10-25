class Product < ApplicationRecord
  # has_one_attached :image
  belongs_to :category
  has_many :wishlist_items, dependent: :destroy
  has_many :wishlists, through: :wishlist_items
  has_many :reviews, dependent: :destroy

  scope :search, ->(query) {
    where("name ILIKE :query OR description ILIKE :query", query: "%#{query}%")
  }
  def average_rating
    reviews.average(:rating).to_f.round(1)
  end


end
