class ProductsController < ApplicationController

  def index
    # @random_products = Product.order("RANDOM()")
    @random_products = Product.page(params[:page]).per(9).order("RANDOM()")
  end

  def show
    @product = Product.find_by(id: params[:id])
  end

  def new
    @product = Product.new
    @song = Song.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = "商品の登録に成功しました"
      redirect_to products_path
    else
      render 'new'
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      flash[:notice] = "商品情報の編集に成功しました"
      redirect_to @product
    else
      render 'edit'
    end
  end

  # def search
  #   @products = Product.search(params[:id])
  # end

  private
    def product_params
      params.require(:product).permit(:product_title, :product_price, :label_id, :genre_id, :explanation,:image, :stock)
    end
end
