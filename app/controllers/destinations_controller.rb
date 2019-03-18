class DestinationsController < ApplicationController
  def index
    # @destinations =Destination.where(user_id:current_user.id)
    # @user = User.find(current_user.id)
    @user = User.first
    @destinations = Destination.where(user_id:1)
  end

  def new
    # @user = User.find(current_user.id)
    @user = User.first
    @destination = Destination.new
  end

  def create
    @user = User.first
    p destination_params
    p destination_params
    p destination_params
    @destination = Destination.new(destination_params)
    @destination.user_id = params[:user_id]
    if @destination.save
      flash[:notice] = "送付先の追加に成功しました"
      redirect_to user_destinations_path(@user)
    else
      render "new"
    end
  end

  def edit
    @user = User.first
    @destination = Destination.find(params[:id])
  end

  def update
    @user = User.first
    @destination = Destination.find(params[:id])
    if @destination.update(destination_params)
      flash[:notice] = "送付先情報を変更しました"
      redirect_to user_destinations_path(@user)
    else
      render "edit"
    end
  end

  def destroy
    @user = User.first
    @destination = Destination.find(params[:id])
    @destination.destroy
    redirect_to user_destinations_path(@user)
  end

  private
    def destination_params
      params.require(:destination).permit(:destination_name, :destination_postcode, :destination_address)
    end

end
