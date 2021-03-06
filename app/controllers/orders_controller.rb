class OrdersController < ApplicationController
  before_action :authenticate_admin, only: [:edit,:update,:index]
  before_action :authenticate_adm_or_correct, only: [:show]

  def index
    @orders = Order.page(params[:page]).reverse_order
  end

  def show
    @order = Order.find(params[:id])
    @user = User.find_by(id: @order.user_id)
    @order_item = Product.find(@order.product_id)
  end

  def create
    # レコード追加処理(ユーザーIDからカート商品テーブル検索（複数）、繰り返し処理でオーダーに洗替)
    # 送付先は渡されたparams[:destination_id]からテーブル検索して持ってくる！
    @cart = Cart.find_by(user_id:current_user.id)
    @user = @cart.user
    @cart_products = CartProduct.where(cart_id:@cart.id)
    @destination_id = session[:selected_dest_id]

    #送付先取得処理
    if @destination_id == "default"
      @destination = @user
    else
      @destination = Destination.find_by(id: @destination_id, user_id: @user.id)
    end
    session.delete(:selected_dest_id)

    #カート商品をオーダーに洗い替えしつつ配列に入れる
    #送付先変更有無で入力情報制御
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
        if left_stock < 0
          flash[:danger] = "購入枚数が在庫数を超えました。在庫を確認してから、商品を入れ直してください。"
          redirect_to cart_path(current_user.cart) and return
        end
        product.stock = left_stock
        product.save
      @order.total_price = cart_product.product.product_price*cart_product.quantity
      @orders << @order
    end

    begin
      Order.transaction do
        @orders.each { |order| order.save! }
      end
      @cart_products.destroy_all #保存完了後はカート内商品削除
      redirect_to carts_thanks_path
      rescue ActionRecord::RecordInvalid, ActionRecord::RecordNotSaved => ex
      flash.now[:danger] = "注文処理でエラーが発生しました"
      redirect_to products_path
    end
  end

  def edit
    @order = Order.find(params[:id])
    @user = User.find_by(id: @order.user_id)
    @order_item = Product.find(@order.product_id)
  end

  def update
    @order = Order.find(params[:id])
    @user = User.find_by(id: @order.user_id)
    @order_item = Product.find(@order.product_id)
    if @order.update(order_params)
      flash[:notice] = "ステータスを更新しました"
      redirect_to order_path(@order.id)
    else
      flash.now[:danger] = "ステータス更新に失敗しました。退会済みユーザーの可能性があります。"
      render :edit
    end
  end

  def destroy
    @order = Order.find(params[:id])
    product = Product.find(@order.product_id)
    if @order.destroy
      if current_user.admin?
        stock = product.stock + @order.quantity
        product.stock = stock
        product.save
        flash[:notice] = "注文を削除しました"
        redirect_to orders_path
      else 
        stock = product.stock + @order.quantity
        product.stock = stock
        product.save
        flash[:notice] = "ご注文をキャンセルしました"
        redirect_to user_path(current_user.id)
      end
    end
  end

  private
    def order_params
      params.require(:order).permit(:status)
    end

end
