class CartProductsController < ApplicationController
  def create
    cart_product = Cart_product.new(cart_id:current_user.cart.id, product_id:params[:product_id], quantity:params[:quantity])
    if cart_product.save
      redirect_to cart_path(current_user.cart)
    else
      flash[:notice] = "カート商品の追加に失敗しました"
      render 'products#index'
    end
  end

  def update
    cart_product = Cart_product.find(params[:id])
    if cart_product.update(cart_params)
      redirect_to cart_path(current_user.cart)
    else
      render 'carts#show'
    end
  end

  def destroy
    cart_product = Cart_product.find(params[:id])
    cart_product.destroy
    redirect_to cart_path(current_user.cart)
  end

  private
    def cart_product_params
      params.require(:cart_product).permit(:quantity)
    end
end
