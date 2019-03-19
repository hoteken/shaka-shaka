class UsersController < ApplicationController
  PER = 8
  def index
    @user = current_user
    @users = User.page(params[:page]).per(PER)
    @search = User.ransack(params[:q])  
    @result = @search.result     
  
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "ユーザーの更新に成功しました"
      redirect_to users_path
    else
      render 'edit'
    end
  end
  private 

  def user_params
    params.require(:user).permit(:name, :name_kana, :postcode, :address, :phone_number,:email)
  end
end
