class ProductsController < ApplicationController
  # before_action :set_product, only: %i[show edit update destroy]
  def index
    @products = Product.all
  end

  def show
    @product = set_product
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product, notice: "Продукт успішно додано!"
    else
      render :new, alert: "Помилка при додаванні продукту."
    end
  end

  def set_product
    @product = Product.find(params[:id])
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :description, :image_url)
  end
end
