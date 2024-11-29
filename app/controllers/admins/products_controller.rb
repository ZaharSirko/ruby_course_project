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
      redirect_to admins_products_path, notice: "Продукт успішно додано!"
    else
      render :new, alert: "Не вдалося додати продукт."
    end
  end
  def edit
    @product = Product.find(params[:id])
  end
  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to admins_products_path, notice: "Product updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to admins_products_path, notice: "Продукт видалено!"
  end


  def set_product
    @product = Product.find(params[:id])
  end

  private

  def authorize_admin
    redirect_to root_path, alert: "У вас немає прав доступу!" unless current_user.admin?
  end

  def product_params
    params.require(:product).permit(:name, :price, :description, :stock, :image_url)
  end
end
