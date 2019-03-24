class SongsController < ApplicationController
  before_action :authenticate_admin
  def index
    @songs = Song.page(params[:page]).reverse_order
    @search = Song.ransack(params[:q])
    @result = @search.result.page(params[:page])
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
    if @song.update(song_params)
      flash[:notice] = "楽曲の更新に成功しました"
      redirect_to songs_path
    else
      render 'edit'
    end
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
