require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  test "today_in_time_zone?" do
    Timecop.freeze("2023-11-03 01:00:00 UTC") do
      time_with_timezone = "2023-11-03 01:00:00 UTC".in_time_zone("America/Boise")

      assert_equal "2023-11-02", time_with_timezone.to_date.to_s
      assert_equal "2023-11-03", Time.current.to_date.to_s

      # False because it is 11/2 in Boise, but 11/3 in UTC.
      assert !time_with_timezone.today?

      assert today_in_time_zone?(time_with_timezone)
    end
  end
end
