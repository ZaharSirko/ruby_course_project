class CartsController < ApplicationController
  before_action :authenticate_user!

  def remove_item
    @cart = current_cart
    cart_item = @cart.cart_items.find_by(product_id: params[:product_id])
    if cart_item
      cart_item.destroy
      redirect_to cart_path(@cart), notice: "Товар було видалено з кошика."
    else
      redirect_to cart_path(@cart), alert: "Не вдалося знайти товар у кошику."
    end
  end

  def add_product
    @cart = current_cart
    @product = Product.find(params[:product_id])
    cart_item = @cart.cart_items.find_by(product: @product)

    if cart_item
      cart_item.update(quantity: cart_item.quantity + 1)
    else
      @cart.cart_items.create(product: @product, quantity: 1)
    end

    redirect_to cart_path(@cart), notice: "Продукт додано до кошика!"
  end


  def update
    @cart = current_cart
    cart_item = @cart.cart_items.find_by(product_id: params[:product_id])

    if cart_item
      cart_item.update(quantity: cart_item.quantity + params[:quantity].to_i)
    else
      cart_item = @cart.cart_items.create(product_id: params[:product_id], quantity: params[:quantity].to_i)
    end

    redirect_to cart_path(@cart), notice: "Кількість оновлено!"
  end


  def show
    @cart = current_cart
  end

  private

  def current_cart
    @current_cart ||= Cart.find_or_create_by(user: current_user)
  end
end
