# This controller is very powerful - it can control the weather!

class WeatherController < ApplicationController
  include WeatherHelper

  def index
  end

  def show
    # TODO: error if location empty.
    location_text = params[:location]

    # Geocoder gem maintains its own cache which it will use if possible.
    results = Geocoder.search(location_text)

    # Some zip codes gave me results in other countries.  Filter those out.
    results.select! { |result| result.country == 'United States' }

    # if no results for US, flash back to index.
    # Take the first result, which I think will be the most specific.
    result = results.first

    if cached_data = Rails.cache.read(result.place_id)
      @weather_cache_hit = true
    else
      @weather_cache_hit = false
      weather = Globals::WeatherClient.one_call(lat: result.data['lat'],
        lon: result.data['lon'], exclude: ['minutely', 'hourly'], 
        units: :imperial)
        
      cached_data = { result: result.data.to_json, weather: weather.to_json }

      Rails.cache.write(result.place_id,  cached_data , expires_in: Globals::WEATHER_TTL)
    end

    @result = JSON.parse(cached_data[:result], symbolize_names: true)
    @weather = JSON.parse(cached_data[:weather], symbolize_names: true)
  end
end
