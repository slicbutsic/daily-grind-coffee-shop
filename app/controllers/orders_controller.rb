class OrdersController < ApplicationController
  before_action :set_order, only: [:show]

  def index
    @orders = current_user.orders
  end
  def show
    # The @order is already set by the before_action
  end

  private

  def set_order
    @order = current_user.orders.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Order not found."
  end
end
