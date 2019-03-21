json.set! @random_product do |product|
	json.name product.product_title
	json.image product.image[:id]
end
#json.set! :aaa do
#	json.test, "test"
#end