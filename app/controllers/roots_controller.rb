class RootsController < ApplicationController
  before_action :authenticate_admin,only: [:admin_top]
  def top
  	#@random_product = Product.order("RANDOM()").first
  end
  def about
  end
  def admin_top
  end
  def shakashaka
    genre_id = params[:genre_id].to_i
    selected_item = Product.where(genre_id:genre_id).where("stock > 0").order("RANDOM()").first
    results = { :title => selected_item.product_title, :image => selected_item.jacket_image, :product_id => selected_item.id }
    render partial: 'shaka_partial', locals: { :results => results, :selected_item => selected_item }
  end
end
