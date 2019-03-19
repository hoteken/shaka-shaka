class CartsController < ApplicationController

  def show
#   @cart = Cart.find_by(user_id: current_user.user_id)
    @cart = Cart.find(1)
    @cart_products = @cart.cart_products
    @sum_price = 0
    @cart_products.each do |cart_product|
      @sum_price += cart_product.quantity * cart_product.product.product_price
    end
  end

  def confirm
    #@cart = Cart.find_by(user_id: current_user.user_id)
    @cart = Cart.find(1)
    @cart_products = @cart.cart_products
    @sum_price = 0
    @cart_products.each do |cart_product|
      @sum_price += cart_product.quantity * cart_product.product.product_price
    end
    @order = Order.new

    #送付先選択用
    @user = User.find(1)
    @destinations = Destination.where(user_id:1)  #ほんとはカレントユーザー

  end

  def thanks
  end

  # ユーザー登録と同時にひもづくカートを作成
  def create
    cart = Cart.new
    cart.user_id = current_user.user_id
    cart.save
    flash[:notice] = "ログインに成功しました"
    redirect_to products_path #ここで合ってる？
  end
end
