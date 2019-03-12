require 'test_helper'

class CartsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get carts_show_url
    assert_response :success
  end

  test "should get confirm" do
    get carts_confirm_url
    assert_response :success
  end

  test "should get thanks" do
    get carts_thanks_url
    assert_response :success
  end

end
