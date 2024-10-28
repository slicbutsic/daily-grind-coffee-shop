class AddressesController < ApplicationController
  before_action :authenticate_user!

  def new
    @address = current_user.addresses.build
  end

  def create
    @address = current_user.addresses.build(address_params)
    if @address.save
      redirect_to new_checkout_path, notice: 'Address confirmed.'
    else
      render :new
    end
  end

  private

  def address_params
    params.require(:address).permit(:street_number, :street_name, :city, :state, :postal_code)
  end
end
