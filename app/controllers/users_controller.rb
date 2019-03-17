class UsersController < ApplicationController
  PER = 8
  def index
    @user = current_user
    @users = User.page(params[:page]).per(PER)
    @search = User.ransack(params[:q])  
    @result = @search.result     
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
  end
end
