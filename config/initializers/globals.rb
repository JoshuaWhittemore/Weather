

module Globals
  WeatherClient =  OpenWeather::Client.new(
      #api_key: "9a48e3030902fa5c8f3e224b607be7e1"
      api_key: ENV['OPEN_WEATHER_API_KEY']
    )
end