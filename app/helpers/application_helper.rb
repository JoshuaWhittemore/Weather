module ApplicationHelper
  # Expects time_with_timezone to be an instance of ActiveSupport::TimeWithZone.
  # Returns true if the date of time_with_timezone is the current date
  # in that time zone.
  #
  def today_in_time_zone?(time_with_timezone)
    time_zone = time_with_timezone.time_zone
    time_with_timezone.to_date == Time.current.in_time_zone(time_zone).to_date
  end


end
