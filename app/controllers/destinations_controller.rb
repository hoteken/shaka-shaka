class DestinationsController < ApplicationController
  before_action :authenticate_adm_or_correct_user

  def index
    @user = User.find(params[:user_id])
    @destinations = Destination.where(user_id:@user.id)
  end

  def new
    @user = User.find(params[:user_id])
    @destination = Destination.new
  end

  def create
    @user = User.find(params[:user_id])
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
    @user = User.find(params[:user_id])
    @destination = Destination.find(params[:id])
  end

  def update
    @user = User.find(params[:user_id])
    @destination = Destination.find(params[:id])
    if @destination.update(destination_params)
      flash[:notice] = "送付先情報を変更しました"
      redirect_to user_destinations_path(@user)
    else
      render "edit"
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @destination = Destination.find(params[:id])
    @destination.destroy
    flash[:notice] = "送付先情報を削除しました"
    redirect_to user_destinations_path(@user)
  end

  private
    def destination_params
      params.require(:destination).permit(:destination_name, :destination_postcode, :destination_address)
    end

end
