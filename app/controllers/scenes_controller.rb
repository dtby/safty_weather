class ScenesController < ApplicationController
  def index
    @scene_weather = Weather.get_scene_data(params[:lon], params[:lat])['data']['items'][0]
    @city_data = Weather.get_city_data['data']
    #p @city_data['data']
    #p @city_data['data']['name']
    respond_to do |format|
      format.html
      format.js
      format.json {head :no_content}
    end
  end
end