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
    cookies[:selected_dest_id] = "default"
    @cart_products = @cart.cart_products
    @sum_price = 0
    @cart_products.each do |cart_product|
      @sum_price += cart_product.quantity * cart_product.product.product_price
    end
    @order = Order.new

    #送付先選択用
    @user = User.find(1)
    @destinations = Destination.where(user_id:@cart.user.id)  #ほんとはカレントユーザー

  end

  def thanks
  end

  # ユーザー登録と同時にひもづくカートを作成
  def create
    cart = Cart.new
    cart.user_id = current_user.user_id
    cart.save
    flash.now[:notice] = "ログインに成功しました"
    redirect_to products_path
  end

  def update
    destination_id = params[:paramss]
    cookies[:selected_dest_id] = destination_id
    selected_dest = Destination.find(destination_id)
    results = { :message => selected_dest.destination_address }
    render partial: 'ajax_partial', locals: { :results => results }
  end

end
