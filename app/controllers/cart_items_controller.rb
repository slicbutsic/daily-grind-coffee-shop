class CartItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart
  before_action :set_cart_item, only: [:update]

  def update
    if @cart_item.update(cart_item_params)
      render json: { success: true }
    else
      render json: { success: false, errors: @cart_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_cart_item
    @cart_item = @cart.cart_items.find(params[:id])
  end

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end
end
