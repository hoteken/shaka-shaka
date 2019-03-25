class UsersController < ApplicationController
  before_action :authenticate_user!,only: [:index,:show]
  before_action :authenticate_admin,only: [:index]
  before_action :authenticate_adm_or_correct_user, only: [:show, :edit, :update]
  
  def index
    @user = current_user
    @users = User.page(params[:page]).reverse_order
    @search = User.ransack(params[:q])  
    @result = @search.result.page(params[:page])     
  
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
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end
  private 

  def user_params
    params.require(:user).permit(:user_name, :user_name_kana, :postcode, :address, :phone_number,:email)
  end
end
