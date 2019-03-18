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
    # レコード追加処理(ユーザーIDからカート商品テーブル検索（複数）、繰り返し処理でオーダーに洗替)
    # 送付先は渡されたparams[:destination_id]からテーブル検索して持ってくる！
    cart_products = CartProduct.where(user_id:1)
    destination = Destination.find(params[:destination_id])

    orders = []
    cart_products.each do |cart_product|
      order = Order.new
      order.user_id = 1
      order.status = 10
      order.destination_name = destination.destination_name
      order.destination_postcode = destination.destination_postcode
      order.destination_address = destination.destination_address
      order.product_id = cart_product.product_id
      order.quantity = cart_product.quantity
      order.total_price = cart_product.product.product_price*cart_product.quantity
      orders << order
    end

    begin
      Order.transaction do
        orders.each { |order| order.save! }
      end
      cart_products.destroy_all
      redirect_to carts_thanks_path
      rescue ActionRecord::RecordInvalid, ActionRecord::RecordNotSaved => ex
      flash[:danger] = "注文処理でエラーが発生しました"
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
