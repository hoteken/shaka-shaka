class SongsController < ApplicationController
  def index
    @songs = Song.page(params[:page]).per(10)
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)
    if @song.save
      flash[:notice] = "楽曲の登録に成功しました"
      redirect_to songs_path
    else
      render 'new'
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])
    # 更新の成功処理
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    redirect_to songs_path
  end

  private
    def song_params
      params.require(:song).permit(:song_title, :artist_id, :track_order, :product_id, :disk_number)
    end
end
