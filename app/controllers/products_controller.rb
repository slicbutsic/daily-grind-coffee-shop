class ProductsController < ApplicationController
  before_action :set_categories

  def index
    @products = Product.all


    if params[:query].present?
      @products = @products.search(params[:query])
    end

    respond_to do |format|
      format.html
    end


    if params[:category_id].present?
      @category = Category.find(params[:category_id])
      @products = @category.products
    else
      @products = Product.all
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  private

  def set_categories
    @categories = Category.all
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :category_id, :image, :intensity)
  end
end
