class Weather2Controller < ApplicationController
  def index
    puts "Weather2Controller#index is executing"
  end

  # get the zip code or city and retrieve the data,
  # which might be stored in the cache.
  # set cache flag true or false depending
  # redirect to show if found, else flash the error and redirect to the
  # index page.
  def retrieve
    location_text = params[:location_text]

    # Geocoder gem maintains its own cache which it will use if possible.
    results = Geocoder.search(location_text)

    # Some zip codes gave me results in other countries.  Filter those out.
    results.select! { |result| result.country == 'United States' }

    # if no results for US, flash back to index.
    # Take the first result, which I think will be the most specific.
    result = results.first
    weather = Globals::WeatherClient.one_call(lat: result.data['lat'],
      lon: result.data['lon'], exclude: ['minutely', 'hourly'], 
      units: :imperial)
    
    cached_data = {result: result.data.to_json, weather: weather.to_json}

    Rails.cache.write(result.place_id,  cached_data , expires_in: Globals::WEATHER_TTL)



#byebug
#     cached_data = Rails.cache.read(zip) 

#     if cached_data
#       @cache_hit = true
#       @current_weather = cached_data[:current_weather]
#       @forecast = cached_data[:forecast]

#     else
#       @cache_hit = false

#       cached_data = {}
#       @current_weather = cached_data[:current_weather] = Globals::WeatherClient.current_weather(zip: zip, units: :imperial)
#       @forecast = cached_data[:forecast] = Globals::WeatherClient.one_call(lat: @current_weather.coord.lat, lon: @current_weather.coord.lon, exclude: ['minutely', 'hourly'], units: :imperial)

#       Rails.cache.write(zip,  cached_data , expires_in: Globals::WEATHER_TTL)
#     end

#    @current_weather = Globals::WeatherClient.current_weather(zip: zip, units: :imperial)
#    @forecast = Globals::WeatherClient.one_call(lat: @current_weather.coord.lat, lon: @current_weather.coord.lon, exclude: ['minutely', 'hourly'], units: :imperial)

    redirect_to weather2_show_path(data: cached_data)# current_weather: @current_weather, forecast: @forecast.to_json, cache_hit: @cache_hit)
  end

  def show
    @result = JSON.parse(params.dig(:data, :result), symbolize_names: true)
    @weather = JSON.parse(params.dig(:data, :weather), symbolize_names: true)
  end
end
