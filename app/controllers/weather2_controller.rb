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
    puts "Weather2Controller#retrieve is executing"
    zip = params[:zip].to_s  # defensive coding

    cached_data = Rails.cache.read(zip) 

    if cached_data
      @cache_hit = true
      @current_weather = cached_data[:current_weather]
      @forecast = cached_data[:forecast]

    else
      @cache_hit = false

      cached_data = {}
      @current_weather = cached_data[:current_weather] = Globals::WeatherClient.current_weather(zip: zip, units: :imperial)
      @forecast = cached_data[:forecast] = Globals::WeatherClient.one_call(lat: @current_weather.coord.lat, lon: @current_weather.coord.lon, exclude: ['minutely', 'hourly'], units: :imperial)

      Rails.cache.write(zip,  cached_data , expires_in: Globals::WEATHER_TTL)
    end

#    @current_weather = Globals::WeatherClient.current_weather(zip: zip, units: :imperial)
#    @forecast = Globals::WeatherClient.one_call(lat: @current_weather.coord.lat, lon: @current_weather.coord.lon, exclude: ['minutely', 'hourly'], units: :imperial)

    redirect_to weather2_show_path(current_weather: @current_weather, forecast: @forecast.to_json, cache_hit: @cache_hit)
  end

  def show
    @forecast = JSON.parse(params["forecast"])
    @current_weather = params['current_weather']
    @cache_hit = params['cache_hit']
    
#byebug

    puts "Weather2Controller#show is executing"
  end
end
