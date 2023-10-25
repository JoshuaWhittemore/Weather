class Weather2Controller < ApplicationController
  def index
    puts "Weather2Controller#index is executing"
  end

  def retrieve
    puts "Weather2Controller#retrieve is executing"

    redirect_to weather2_show_url

  end

  def show
    puts "Weather2Controller#show is executing"
  end
end
