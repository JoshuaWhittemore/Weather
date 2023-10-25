require "test_helper"

class WeatherControllerTest < ActionDispatch::IntegrationTest
  test "should get input" do
    get weather_input_url
    assert_response :success
  end

  test "should get display" do
    get weather_display_url
    assert_response :success
  end
end
