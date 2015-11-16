class HomeController < ApplicationController
  def index
    @now = Time.now.strftime("%Y-%m-%d")
    @weather_info_first = Weather.get_weather_data['data'][0]
    @weather_info = Weather.get_weather_data['data'][1..4]
    @aqi_info = Weather.get_aqi_data['data']
  end
end