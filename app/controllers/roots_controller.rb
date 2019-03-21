class RootsController < ApplicationController
  def top
  	@random_product = Product.order("RANDOM()").first
  end
  def about
  end

  def admin_top
  end
end
