require 'test_helper'

class CartProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get cart_products_create_url
    assert_response :success
  end

  test "should get update" do
    get cart_products_update_url
    assert_response :success
  end

  test "should get destroy" do
    get cart_products_destroy_url
    assert_response :success
  end

end
