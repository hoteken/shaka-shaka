class CartProductsController < ApplicationController
  def create
    cart_product = CartProduct.new(cart_id:params[:cart_id], 
                                    product_id: params[:cart_product][:product_id], 
                                    quantity: params[:cart_product][:quantity])
    if cart_product.save
      #redirect_to cart_path(current_user.cart)
      redirect_to cart_path(1)
    else
      flash[:danger] = "カート商品の追加に失敗しました"
      redirect_to products_path
    end
  end

  def update
    cart_product = CartProduct.find(params[:id])
    if cart_product.update(quantity: params[:cart_product][:quantity])
      #redirect_to cart_path(current_user.cart)
      redirect_to cart_path(1)
    else
      render 'carts#show'
    end
  end

  def destroy
    cart_product = CartProduct.find_by(id:params[:id])
    cart_product.destroy
    # redirect_to cart_path(current_user.cart)
    flash[:notice] = "カート商品を削除しました"
    redirect_to cart_path(1)
  end

end
