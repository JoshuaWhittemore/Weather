# This controller is very powerful - it can control the weather!

class WeatherController < ApplicationController
  include WeatherHelper

  def index
  end

  def show
    location_text = params[:location]

    if (geocoder_result = LocationService.find(location_text))
      flash[:notice] = "Location found for input '#{location_text}'."
    else
      flash[:alert] = "No valid location found for input '#{location_text}'."
      redirect_to action: :index
      return
    end

    data = WeatherService.get(geocoder_result)
    @weather_cache_hit = data[:cache_hit]
    @result = JSON.parse(data[:result], symbolize_names: true)
    @weather = JSON.parse(data[:weather], symbolize_names: true)
  end
end
