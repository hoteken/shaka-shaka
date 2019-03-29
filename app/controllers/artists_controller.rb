class ArtistsController < ApplicationController
  before_action :authenticate_admin
  def index
    @artists = Artist.page(params[:page]).reverse_order
    @search = Artist.ransack(params[:q])
    @result = @search.result.page(params[:page])
  end

  def new
    @artist = Artist.new
  end

  def create
    @artist = Artist.new(artist_params)
    if @artist.save
      flash[:notice] = "アーティストの追加に成功しました"
      redirect_to artists_path
    else
      render :new
    end
  end

  def edit
    @artist = Artist.find(params[:id])
  end

  def update
    @artist = Artist.find(params[:id])
    if @artist.update(artist_params)
      flash[:notice] = "アーティストを変更しました"
      redirect_to artists_path
    else
      render :edit
    end
  end

  private
  def artist_params
    params.require(:artist).permit(:artist_name)
  end
end
