require "test_helper"

VCR.configure do |config|
  config.cassette_library_dir = 'test/vcr_cassettes'
  config.hook_into :webmock
end

class WeatherServiceTest < ActiveSupport::TestCase

  test "gets weather data" do
    VCR.use_cassette(__method__) do
      geocoder_result = LocationService.find('509 W 32nd Street, Vancouver, WA 98660')
      data = WeatherService.get(geocoder_result)
      weather = JSON.parse(data[:weather], symbolize_names: true)

      assert_equal 38.59, weather.dig(:current, :temp)
    end
  end
end
