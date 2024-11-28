class OrdersController < ApplicationController
  def new
    @order = Order.new
  end
  def create
    @order = current_user.orders.build(order_params)
    @order.total_price = calculate_total_price
    @order.status = "Pending"
    if @order.save
      process_payment
      clear_cart
      redirect_to root_path, notice: "Замовлення успішно оформлене"
    else
      flash[:alert] = "Помилка під час створення замовлення"
      render :new
    end
  end

  private
  def order_params
    params.require(:order).permit(:delivery_type, :status)
  end

  def calculate_total_price
    current_cart.cart_items.sum { |item| item.product.price * item.quantity }
  end

  def clear_cart
    current_cart.cart_items.destroy_all
  end

  def process_payment
    Stripe::Charge.create(
      amount: (@order.total_price * 100).to_i,
      currency: "usd",
      source: params[:stripeToken],
      description: "Order ID: #{@order.id}"
    )
  end
end
