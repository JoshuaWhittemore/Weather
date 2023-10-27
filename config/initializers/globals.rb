module Globals
  WeatherClient = OpenWeather::Client.new(api_key: ENV["OPEN_WEATHER_API_KEY"])
  WEATHER_TTL = 1.minute
end
