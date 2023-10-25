require "test_helper"

class Weather2ControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get weather2_index_url
    assert_response :success
  end

  test "should get show" do
    get weather2_show_url
    assert_response :success
  end
end
