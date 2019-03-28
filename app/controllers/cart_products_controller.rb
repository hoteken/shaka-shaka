class CartProductsController < ApplicationController
  before_action :authenticate_user!
  def create
    cart_product = CartProduct.new(cart_id:params[:cart_id], 
                                    product_id: params[:cart_product][:product_id], 
                                    quantity: params[:cart_product][:quantity])
    #初めから在庫数以上入れられないよう制御
    if cart_product.quantity > cart_product.product.stock
      flash[:danger] = "購入希望数が在庫数を超えています"
      redirect_to product_path(cart_product.product) and return
    end

    #同じ商品がすでにあれば、個数だけ加算して旧レコードはデリート
    if bef_cart_product = CartProduct.find_by(product_id: cart_product.product.id)
      cart_product.quantity += bef_cart_product.quantity
      bef_cart_product.destroy
    end

    #商品カート追加処理
    if cart_product.save
      flash[:notice] = "カートに商品を追加しました"
      redirect_to cart_path(current_user.cart)
    else
      flash[:danger] = "カート商品の追加に失敗しました"
      redirect_to products_path
    end
  end

  def update
    cart_product = CartProduct.find(params[:id])
    if cart_product.update(quantity: params[:cart_product][:quantity])
      flash[:notice] = "商品の個数を更新しました"
      redirect_to cart_path(current_user.cart)
    else
      render 'carts#show'
    end
  end

  def destroy
    cart_product = CartProduct.find_by(id:params[:id])
    cart_product.destroy
    flash[:notice] = "カート商品を削除しました"
    redirect_to cart_path(current_user.cart)
  end

end
