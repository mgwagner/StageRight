require 'test_helper'

class LoginControllerTest < ActionDispatch::IntegrationTest
  test "should get Index" do
    get login_Index_url
    assert_response :success
  end

end
