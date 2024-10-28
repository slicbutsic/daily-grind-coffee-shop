class AddressesController < ApplicationController
  include CurrentCart
  before_action :set_cart
  before_action :authenticate_user!

  def new
    @address = current_user.addresses.build(state: 'QLD')
    @cart_total = @cart.total_price
  end

  def create
    @address = current_user.addresses.build(address_params)
    if @address.save
      session[:shipping_cost] = ShippingCalculator.calculate(@address.state, params[:shipping_option] == 'fast')
      redirect_to new_checkout_path, notice: 'Address confirmed.'
    else
      @cart_total = @cart.total_price
      render :new
    end
  end

  def calculate_shipping
    state = params[:state]
    @normal_shipping_cost = ShippingCalculator.calculate(state, false)
    @fast_shipping_cost = ShippingCalculator.calculate(state, true)
    @cart_total = @cart.total_price
    render partial: 'shipping_options', locals: {
      normal_shipping_cost: @normal_shipping_cost,
      fast_shipping_cost: @fast_shipping_cost,
      cart_total: @cart_total
    }
  end

  private

  def address_params
    params.require(:address).permit(:street_number, :street_name, :city, :state, :postal_code)
  end
end
