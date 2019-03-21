class Api::RootsController < ApplicationController
  def top
  	@random_product = Product.order("RANDOM()").first
  	render :json => {
  		name: @random_product.product_title,
  		image: @random_product.image
  	}
  end
end
