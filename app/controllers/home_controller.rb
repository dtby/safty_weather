class HomeController < ApplicationController
  def index
    @now = Time.now.strftime("%Y-%m-%d")
    @weather_info_first = Weather.get_weather_data['data'][0]

    @weather_info = Weather.get_weather_data['data'][1..-2]  #页面需要，显示未来八天的天气
    gon.weather_info = @weather_info

    @aqi_info = Weather.get_aqi_data['data']
    @life_info = Weather.get_life_data['data']['list'][-5]['mean']
  end
end