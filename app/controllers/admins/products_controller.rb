class Admins::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin

  def index
    @products = Product.all
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


  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: "Продукт успішно оновлено!"
    else
      render :edit, alert: "Помилка при оновленні продукту."
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path, notice: "Продукт видалено!"
  end


  def set_product
    @product = Product.find(params[:id])
  end

  private

  def authorize_admin
    redirect_to root_path, alert: "У вас немає прав доступу!" unless current_user.admin?
  end

  def product_params
    params.require(:product).permit(:name, :price, :description, :image_url)
  end
end
