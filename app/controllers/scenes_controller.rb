class ScenesController < ApplicationController
  def index
    @scene_weather = Weather.get_scene_data(params[:lon], params[:lat])['data']['items'][0]
    @city_data = Weather.get_city_data(params[:lon], params[:lat])['data']
    p @city_data['name']
    p @city_data['tempe']
    respond_to do |format|
      format.html
      format.js
      format.json {head :no_content}
    end
  end
end