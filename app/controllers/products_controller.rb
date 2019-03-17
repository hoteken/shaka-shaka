class ProductsController < ApplicationController

  def index
    @random_products = Product.page(params[:page]).per(9).order("RANDOM()")
  end

  def show
    @product = Product.find_by(id: params[:id])
    @songs = @product.songs
    
    #ディスクごとの曲名表示用
    @max_disk_num = @songs.maximum(:disk_number)  #ディスク枚数をカウント
    @disked_songs = []
    (1..@max_disk_num).each do |disk_num|
      @disked_songs << @songs.where(disk_number: disk_num).order("track_order asc")  #ディスク番号ごとに曲をまとめ、収録順に配列に代入
    end
    @disk_count = 1 #ディスク番号表示&ループ用

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

  private
    def product_params
      params.require(:product).permit(:product_title, :product_price, :label_id, :genre_id, :explanation,:image, :stock)
    end
end
