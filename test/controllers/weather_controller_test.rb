require "test_helper"

VCR.configure do |config|
  config.cassette_library_dir = "test/vcr_cassettes"
  config.hook_into :webmock
end

class WeatherControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    VCR.use_cassette(__method__) do
      get weather_index_url
      assert_response :success
    end
  end

  test "should get show" do
    VCR.use_cassette(__method__) do
      get weather_show_url, params: {location: "Sacramento, CA"}
      assert_response :success

      assert_equal false, assigns(:weather_cache_hit)
      assert_equal "Sacramento, Sacramento County, California, United States",
        assigns(:result)[:display_name]
      assert_equal 39.81, assigns(:weather).dig(:current, :temp)
    end
  end
end
