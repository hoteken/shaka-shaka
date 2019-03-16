class ProductsController < ApplicationController

  def index
    @random_products = Product.page(params[:page]).per(9).order("RANDOM()")
  end

  def show
    @product = Product.find_by(id: params[:id])
    @songs = @product.songs.group(:disk_number)

      # 商品に紐づく曲を持ってくる
      #   @product.songs
      # ディスクごとに分ける（何枚ディスクがあるかは不明）
      #   @product.songs.where(disk_number:＊)
      #     for文でディスク番号をインクリメントしながら取ってくる
      #     （終わりは、ディスクNoの最大値を持ってきて＞＝で閉める）@product.songs.maximum(:disk_number)
      # ディスクごとに配列を作って、その中に配列で曲を入れればいいのか！！！
      # for (i=1; i<= @product.songs.maximum(:disk_number); i++)
      #   disk_i_songs = @product.songs.where(disk_number: i)
      #   orderd_disk_i_songs = disk_i_songs.order("track_order asc")
      # end

      # product.songs.group(:disk_number)   #ディスク番号ごとの曲グループをハッシュ化

      # 曲順で並び替える
      #   @product.songs.where(disk_number:＊).order("track_order asc")
      #
      # 表示する（ディスクごとに場所を用意する必要）デフォで4枚用意して「なし」でもいいかも

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
