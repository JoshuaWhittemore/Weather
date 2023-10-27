require "test_helper"

VCR.configure do |config|
  config.cassette_library_dir = "test/vcr_cassettes"
  config.hook_into :webmock
end

class LocationServiceTest < ActiveSupport::TestCase
  test "finds regular address" do
    VCR.use_cassette(__method__) do
      geocoder_result = LocationService.find("509 W 32nd Street, Vancouver, WA 98660")

      assert_equal 313605545, geocoder_result.place_id
      assert_equal "509, West 32nd Street, Carter Park, Vancouver, Clark County, Washington, 98660, United States",
        geocoder_result.display_name
    end
  end

  test "finds by city and state" do
    VCR.use_cassette(__method__) do
      geocoder_result = LocationService.find("Sacramento, CA")

      assert_equal 310488782, geocoder_result.place_id
      assert_equal "Sacramento, Sacramento County, California, United States",
        geocoder_result.display_name
    end
  end

  test "finds by zip code only" do
    VCR.use_cassette(__method__) do
      geocoder_result = LocationService.find("01770")

      assert_equal 331058129, geocoder_result.place_id
      assert_equal "Sherborn, Middlesex County, 01770, Massachusetts, United States",
        geocoder_result.display_name
    end
  end
end
