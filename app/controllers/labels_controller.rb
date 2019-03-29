class LabelsController < ApplicationController
  before_action :authenticate_admin
  def index
    @labels = Label.page(params[:page]).reverse_order
    @search = Label.ransack(params[:q])
    @result = @search.result.page(params[:page])
  end

  def new
    @label = Label.new
  end

  def create
    @label = Label.new(label_params)
    if @label.save
    flash[:notice] = "レーベルの追加に成功しました"
    redirect_to labels_path
    else
    render :new
    end
  end

  def edit
    @label = Label.find(params[:id])
  end

  def update
    @label = Label.find(params[:id])
    if @label.update(label_params)
       flash[:notice] = "レーベル情報を変更しました"
       redirect_to labels_path
    else
       render :edit
    end
  end

  private
  def label_params
    params.require(:label).permit(:label_name)
  end
end
