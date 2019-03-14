class ArtistsController < ApplicationController
  def index
    @artists = Artist.page(params[:page]).reverse_order
  end

  def new
    @artist = Artist.new
  end

  def create
    artist = Artist.new(artist_params)
    artist.save
    redirect_to "/artists"
  end

  def edit
    @artist = Artist.find(params[:id])
  end

  def update
    artist = Artist.find(params[:id])
    artsit.update(artist_params)
    redirect_to "/artists"
  end

  def artist_params
    params.require(:artist).permit(:artist_name)
  end
end
