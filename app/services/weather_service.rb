module WeatherService

  BASE_URL = "https://api.openweathermap.org/data/3.0/onecall?appid=#{Globals::OPEN_WEATHER_API_KEY}&exclude=hourly,minutely&units=imperial"


  def self.request_url(result)
    BASE_URL + "&lat=#{result.data["lat"]}" + "&lon=#{result.data["lon"]}"
  end
  
  def self.get_direct(result)
    response = HTTParty.get(request_url(result))

    if response.success?
      JSON.parse(response.body)
    else
      # check this case by passing a bad api key, etc.
      raise "request to openeweather map failed."
    end
  end


  def self.get(result)

    weather = get_direct(result)

    # Convert to json so data can be cached as a string if nec.
    data = {result: result.data.to_json, weather: weather.to_json}

    return data

    # if (data = Rails.cache.read(result.place_id))
    #   data[:cache_hit] = true
    # else
    #   weather = Globals::WeatherClient.one_call(lat: result.data["lat"],
    #     lon: result.data["lon"], exclude: ["minutely", "hourly"],
    #     units: :imperial)

    #   data = {result: result.data.to_json, weather: weather.to_json}
    #   Rails.cache.write(result.place_id, data, expires_in: Globals::WEATHER_TTL)
    #   data[:cache_hit] = false
    # end

    # data
  end
end
