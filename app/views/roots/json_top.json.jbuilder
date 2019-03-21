json.array! @random_products do |product|
	json.name product.product_title
	json.image product.image
end