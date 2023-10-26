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
    zip = params[:zip]

    @current_weather = Globals::WeatherClient.current_weather(zip: zip, units: :imperial)
    @forecast = Globals::WeatherClient.one_call(lat: @current_weather.coord.lat, lon: @current_weather.coord.lon, exclude: ['minutely', 'hourly'], units: :imperial)

    redirect_to weather2_show_path(current_weather: @current_weather, forecast: @forecast.to_json)
  end

  def show
    @forecast = JSON.parse(params["forecast"])
    @current_weather = params['current_weather']

#byebug

    puts "Weather2Controller#show is executing"
  end
end
