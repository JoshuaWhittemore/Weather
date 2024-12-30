module WeatherHelper
  def extract_weekday(day, timezone)
    datetime = Time.at(day[:dt]) 

    time_w_zone = datetime.in_time_zone(timezone)

    if today_in_time_zone?(time_w_zone)
      "Today"
    else
      time_w_zone.strftime("%a")
    end
  end

  def extract_icon(day)
    icon_code = day.dig(:weather, 0, :icon)

    "https://openweathermap.org/img/wn/#{icon_code}@2x.png"
  end
  
  def local_datetime(timestamp, timezone)
    datetime = Time.at(timestamp) #.in_time_zone("Eastern Time (US & Canada)")

    #parsed_datetime = DateTime.parse(utc_dt_str)
    desired_time_zone = ActiveSupport::TimeZone[timezone]
    datetime.in_time_zone(desired_time_zone)
  end


  # def local_datetime(utc_dt_str, timezone)
  #   parsed_datetime = DateTime.parse(utc_dt_str)
  #   desired_time_zone = ActiveSupport::TimeZone[timezone]
  #   parsed_datetime.in_time_zone(desired_time_zone)
  # end
end
