class CheckoutsController < ApplicationController
  before_action :set_cart

  def new
    redirect_to root_path, alert: "Your cart is empty." if @cart.cart_items.empty?
  end

  def create
    @cart = current_user.cart
    amount = (@cart.total_price * 100).to_i # amount in cents

    begin
      customer = Stripe::Customer.create(
        email: current_user.email,
        source: params[:stripeToken]
      )

      charge = Stripe::Charge.create(
        customer: customer.id,
        amount: amount,
        description: 'Rails Stripe customer',
        currency: 'usd'
      )

      if charge.paid?
        order = current_user.orders.create(total: @cart.total_price, status: 'paid')
        @cart.cart_items.each do |item|
          order.order_items.create(
            product: item.product,
            quantity: item.quantity,
            price: item.product.price
          )
        end
        @cart.cart_items.destroy_all
        redirect_to order_path(order), notice: 'Payment successful!'
      else
        redirect_to cart_path, alert: 'Payment failed.'
      end

    rescue Stripe::CardError => e
      redirect_to new_checkout_path, alert: e.message
    end
  end

  private

  def set_cart
    @cart = current_user.cart
    redirect_to root_path, alert: "You don't have a cart." unless @cart
  end
end
