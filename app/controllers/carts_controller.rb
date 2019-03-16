class CartsController < ApplicationController

  def show
    @cart = Cart.find_by(user_id: current_user.user_id)
    @cart_products = @cart.products
    @sum_price = @cart_products.sum(:product_price)
  end

  def confirm
    @cart = Cart.find_by(user_id: current_user.user_id)
    @cart_products = @cart.products
    @sum_price = @cart_products.sum(:product_price)
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
