class OrdersController < ApplicationController
  before_action :authenticate_user!, :set_categories

  def index
    @orders = current_user.orders.order(created_at: :desc)
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  private

  def set_categories
    @categories = Category.all
  end
end
