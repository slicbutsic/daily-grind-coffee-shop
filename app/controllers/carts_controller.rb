class CartsController < ApplicationController
  include CurrentCart
  before_action :set_cart

  def show
    @cart_items = @cart.cart_items.includes(:product)
    render partial: 'cart_contents' if request.xhr?
  end

  def add_item
    product = Product.find(params[:product_id])
    @cart.add_product(product)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace("cart_icon_#{product.id}", partial: 'carts/cart_icon', locals: { product: product }),
          turbo_stream.replace("cart_button", partial: 'shared/cart_button', locals: { cart: @cart })
        ]
      end
      format.html { redirect_back(fallback_location: root_path) }
    end
  end

  def update_quantity
    @cart_item = @cart.cart_items.find(params[:item_id])
    new_quantity = @cart_item.quantity + params[:change].to_i

    if new_quantity > 0
      @cart_item.update(quantity: new_quantity)
    else
      @cart_item.destroy
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "cart-contents",
          partial: 'carts/cart_contents',
          locals: { cart: @cart }
        )
      end
      format.html { redirect_to cart_path }
    end
  end

  def empty
    @cart.cart_items.destroy_all

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace("cart-contents", partial: 'carts/cart_contents', locals: { cart: @cart }),
          turbo_stream.replace("cart_button", partial: 'shared/cart_button', locals: { cart: @cart })
        ]
      end
      format.html { redirect_to products_path, notice: 'Cart emptied successfully.' }
    end
  end

  private

  def set_cart
    @cart = Cart.find_by(id: session[:cart_id]) || Cart.create.tap { |cart| session[:cart_id] = cart.id }
  end
end
