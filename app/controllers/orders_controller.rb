class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    @order = current_user.orders.build(order_params)
    if @order.save
      process_payment
      redirect_to root_path, notice: "Замовлення успішно оформлене"
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:total_price, :status)
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
