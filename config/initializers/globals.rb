module Globals
  #WeatherClient = OpenWeather::Client.new(api_key: ENV["OPEN_WEATHER_API_KEY"])
  OPEN_WEATHER_API_KEY = ENV["OPEN_WEATHER_API_KEY"]
  WEATHER_TTL = 30.minutes
end
