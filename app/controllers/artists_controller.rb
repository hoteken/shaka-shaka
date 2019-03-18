class ArtistsController < ApplicationController
  def index
    @artists = Artist.page(params[:page]).reverse_order
    @search = Artist.ransack(params[:q])
    @result = @search.result.page(params[:page])
  end

  def new
    @artist = Artist.new
  end

  def create
    artist = Artist.new(artist_params)
    if artist.save
       redirect_to artists_path
    else
       redirect_to new_artist_path
    end
  end

  def edit
    @artist = Artist.find(params[:id])
  end

  def update
    artist = Artist.find(params[:id])
    if artist.update(artist_params)
       redirect_to artists_path
    else
       redirect_to edit_artist_path
    end
  end

  private
  def artist_params
    params.require(:artist).permit(:artist_name)
  end
end
