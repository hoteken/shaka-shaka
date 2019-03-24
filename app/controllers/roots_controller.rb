class RootsController < ApplicationController
  def top
  	@random_product = Product.order("RANDOM()").first
  end
  def about
  end

  def admin_top
  end
  def shakashaka
    genre_id = params[:genre_id].to_i
    selected_item = Product.where(genre_id:genre_id).order("RANDOM()").first
    results = { :title => selected_item.product_title, :image => selected_item.image, :product_id => selected_item.id }
    render partial: 'shaka_partial', locals: { :results => results, :selected_item => selected_item }
  end
end
