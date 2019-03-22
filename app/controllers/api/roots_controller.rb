class Api::RootsController < ApplicationController
  def top
  	@random_product = Product.order("RANDOM()").first
  	render :json => {
  		id: @random_product.id,
  		image: @random_product.image_id
  	}
  end
end
