module WeatherHelper

  def extract_weekday(day)
    datetime = DateTime.parse(day.dig(:dt))
    datetime.strftime("%a")
  end
  
  def extract_icon(day)
    day.dig(:weather, 0, :icon_uri)
  end

  def local_datetime(utc_dt_str, timezone)
    parsed_datetime = DateTime.parse(utc_dt_str)
    desired_time_zone = ActiveSupport::TimeZone[timezone]
    parsed_datetime.in_time_zone(desired_time_zone)
  end
end
