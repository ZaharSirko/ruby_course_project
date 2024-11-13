class CartsController < ApplicationController
  def show
    @cart = current_user.cart || Cart.create(user: current_user)
  end


  def add_product
    @cart = current_cart
    @product = Product.find(params[:product_id])
    @cart.add_product(@product)
    redirect_to cart_path(@cart), notice: "Продукт додано до кошика!"
  end


  def update
    cart_item = CartItem.find_or_initialize_by(cart_id: current_user.cart.id, product_id: params[:product_id])
    cart_item.quantity += params[:quantity].to_i
    cart_item.save
    redirect_to cart_path
  end
end
