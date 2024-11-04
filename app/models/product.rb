class Product < ApplicationRecord
  # has_one_attached :image
  belongs_to :category
  has_many :wishlist_items, dependent: :destroy
  has_many :wishlists, through: :wishlist_items
  has_many :reviews, dependent: :destroy


  validates :second_image, presence: true
  validates :intensity, presence: true,
  numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 10 },
  if: :coffee?

  def coffee?
    category.name.downcase == 'coffee beans'
  end

  scope :search, ->(query) {
    where("name ILIKE :query OR description ILIKE :query", query: "%#{query}%")
  }
  def average_rating
    reviews.average(:rating).to_f.round(1)
  end

  def self.coffees_of_the_month(limit = 4)
    coffee_beans = Category.find_by(name: "Coffee Beans")
    where(category: coffee_beans).order("RANDOM()").limit(limit)
  end

end
