class WishlistsController < ApplicationController
  before_action :authenticate_user!, except: [:toggle_item]
  before_action :set_wishlist, :set_categories, except: [:toggle_item]

  def show
    @wishlist_products = @wishlist.products
  end

  def toggle_item
    @product = Product.find(params[:id])

    if user_signed_in?
      @wishlist = current_user.wishlist || current_user.create_wishlist
      added = @wishlist.toggle_product(@product)
      render_heart_icon(added)
    else
      render_login_prompt
    end
  end

  private

  def set_wishlist
    @wishlist = current_user.wishlist || current_user.create_wishlist
  end

  def set_categories
    @categories = Category.all
  end

  def render_heart_icon(added)
    render turbo_stream: turbo_stream.replace(
      "wishlist_icon_#{@product.id}",
      partial: 'wishlists/heart_icon',
      locals: { product: @product, added: added }
    )
  end

  def render_login_prompt
    render turbo_stream: turbo_stream.replace(
      "wishlist_icon_#{@product.id}",
      partial: 'wishlists/login_prompt',
      locals: { product: @product }
    )
  end
end
