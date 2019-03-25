class ProductsController < ApplicationController
  before_action :authenticate_admin, only: [:new, :create, :edit, :update]

  def index(genre_id = nil)
    genre_id = params[:format]
    if genre_id.nil?
      @random_products = Product.page(params[:page]).per(9).order("RANDOM()")
    else
      @random_products = Product.where(genre_id:genre_id).page(params[:page]).per(9).order("RANDOM()")
    end
    @search = @random_products.ransack(params[:q])
    @result = @search.result.page(params[:page])

    # カート追加用
    if user_signed_in?
      @cart = Cart.find_by(user_id:current_user.id)
      @cart_product = CartProduct.new
    end
  end

  def show
    @product = Product.find_by(id:params[:id])
    @songs = @product.songs

    # カート追加用
    if user_signed_in?
      @cart = Cart.find_by(user_id:current_user.id)
      @cart_product = CartProduct.new
    end
    
    #ディスクごとの曲名表示用
    if @songs.count > 0
      @max_disk_num = @songs.maximum(:disk_number)  #ディスク枚数をカウント
      @disked_songs = []
      (1..@max_disk_num).each do |disk_num|
        @disked_songs << @songs.where(disk_number: disk_num).order("track_order asc")  #ディスク番号ごとに曲をまとめ、収録順に配列に代入
      end
    end

  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash.now[:notice] = "商品の登録に成功しました"
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

  private
    def product_params
      params.require(:product).permit(:product_title, :product_price, :label_id, :genre_id, :explanation,:image, :stock)
    end
end
