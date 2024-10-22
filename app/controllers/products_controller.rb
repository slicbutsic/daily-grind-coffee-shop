class ProductsController < ApplicationController
  before_action :set_categories

  def index
    @products = Product.all

    if params[:query].present?
      @products = @products.search(params[:query])
    end

    respond_to do |format|
      format.html # This will render the index.html.erb by default
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  private

  def set_categories
    @categories = Category.all
  end
end
