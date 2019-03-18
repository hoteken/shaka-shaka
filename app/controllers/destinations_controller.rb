class DestinationsController < ApplicationController
  def index
    @destinations =Destination.all
  end

  def new
    @destination = Destination.new
  end

  def create
    destination = Destination.new(destination_params)
    destination.save
    redirect_to user_destinations_path
  end

  def edit
    @destination = Artist.find(params[:id])
  end

  def update
  end

  def destroy
  end

  private
  def destination_params
     params.require(:destination).permit(:destination_name, :destination_postcode, :destination_address)
  end

end

