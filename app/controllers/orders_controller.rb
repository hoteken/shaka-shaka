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
    @cart = Cart.find(1)
    @user = @cart.user
    @cart_products = CartProduct.where(cart_id:@cart.id)
    @destination_id = cookies[:selected_dest_id]

    if @destination_id == "default"
      @destination = @user
    else
      @destination = Destination.find_by(id: @destination_id, user_id: @user.id)
    end
    cookies.delete :selected_dest_id
    # @destination = Destination.find(params[:order][:destination_id])

    @orders = []
    @cart_products.each do |cart_product|
      @order = Order.new
      @order.user_id = @user.id
      @order.status = 10
      if @destination_id == "default"
        @order.destination_name = @user.user_name
        @order.destination_postcode = @user.postcode
        @order.destination_address = @user.address
      else
        @order.destination_name = @destination.destination_name
        @order.destination_postcode = @destination.destination_postcode
        @order.destination_address = @destination.destination_address
      end
      @order.product_id = cart_product.product_id
      @order.quantity = cart_product.quantity
      # 在庫を減算
        product = cart_product.product
        left_stock = product.stock - @order.quantity
        product.stock = left_stock
        product.save
      @order.total_price = cart_product.product.product_price*cart_product.quantity
      @orders << @order
    end

    begin
      Order.transaction do
        @orders.each { |order| order.save! }
      end
      @cart_products.destroy_all
      redirect_to carts_thanks_path
      rescue ActionRecord::RecordInvalid, ActionRecord::RecordNotSaved => ex
      flash.now[:danger] = "注文処理でエラーが発生しました"
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
      flash.now[:notice] = "ステータスを更新しました"
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
