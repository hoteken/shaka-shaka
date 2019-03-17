class LabelsController < ApplicationController
  def index
    @labels = Label.page(params[:page]).reverse_order
    @search = Label.ransack(params[:q])
    @result = @search.result
  end

  def new
    @label = Label.new
  end

  def create
    label = Label.new(label_params)
    label.save
    redirect_to "/labels"
  end

  def edit
    @label = Label.find(params[:id])
  end

  def update
    label = Label.find(params[:id])
    label.update(label_params)
    redirect_to "/labels"
  end

    private
  def label_params
    params.require(:label).permit(:label_name)
  end
end
