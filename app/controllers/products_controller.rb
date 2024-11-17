class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = set_product
  end


  def set_product
    @product = Product.find(params[:id])
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :description, :image_url)
  end
end
