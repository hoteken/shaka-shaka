class OrdersController < ApplicationController
  def index
    @orders = Order.page(params[:page]).reverse_order
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    @order.user.cart_id = current_user.id
    @order.save
    redirect_to carts_thanks_path
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      redirect_to order_path(@order.id)
    else
      render :edit
    end
  end

  private
  def order_params
    params.require(:order).permit(:user_id, :destination_id, :product_id,  :status, :quantity, :total_price)
  end

end
