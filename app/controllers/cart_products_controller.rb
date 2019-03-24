class CartProductsController < ApplicationController
  before_action :authenticate_user!
  def create
    cart_product = CartProduct.new(cart_id:params[:cart_id], 
                                    product_id: params[:cart_product][:product_id], 
                                    quantity: params[:cart_product][:quantity])

    if cart_product.quantity > cart_product.product.stock
      flash[:danger] = "購入希望数が在庫数を超えています"
      redirect_to product_path(cart_product.product)
    else
      if cart_product.save
        redirect_to cart_path(current_user.cart)
      else
        flash[:danger] = "カート商品の追加に失敗しました"
        redirect_to products_path
      end
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
