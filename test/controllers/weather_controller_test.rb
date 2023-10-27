require "test_helper"

class WeatherControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get weather_index_url
    assert_response :success
  end

  test "should get show" do
    get weather_show_url, params: { location: "Sacramento, CA" }
    assert_response :success
  end
end
