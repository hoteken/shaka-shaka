class OrdersController < ApplicationController
  def index
    @orders = Order.page(params[:page]).reverse_order
  end

  def show
    @order = Order.find(params[:id])
    @user = User.find(@order.user_id)
    @order_item = Product.find(@order.product_id)
  end

  def create
    order = Order.new

    # レコード追加処理
    order.user_id = 1
    order.status = 10
    order.destination_name = params[:destination_name]
    order.destination_postcode = params[:destination_postcode]
    order.destination_address = params[:destination_address]
    order.product_id = params[:product_id]
    order.quantity = params[:quantity]
    order.total_price = params[:total_price]
    
    if @order.save

      # cart_productのレコード削除

      redirect_to carts_thanks_path
    else
      flash[:danger] = "注文処理に失敗しました"
      redirect_to products_path
    end
    
  end

  def edit
    @order = Order.find(params[:id])
    @user = User.find(@order.user_id)
    @order_item = Product.find(@order.product_id)
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      flash[:notice] = "ステータスを更新しました"
      redirect_to order_path(@order.id)
    else
      render :edit
    end
  end

  private
    def order_params
      params.require(:order).permit(:status)
    end

end
