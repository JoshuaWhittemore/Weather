class WeatherService
  # def self.get(geocoder_result)
  def self.get(result)
    if (data = Rails.cache.read(result.place_id))
      data[:cache_hit] = true
    else
      weather = Globals::WeatherClient.one_call(lat: result.data["lat"],
        lon: result.data["lon"], exclude: ["minutely", "hourly"],
        units: :imperial)

      data = {result: result.data.to_json, weather: weather.to_json}
      Rails.cache.write(result.place_id, data, expires_in: Globals::WEATHER_TTL)
      data[:cache_hit] = false
    end

    data
  end
end
