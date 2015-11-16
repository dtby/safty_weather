class ScenesController < ApplicationController
  def index
    @scene_weather = Weather.get_scene_data(params[:lon], params[:lat])
  end
end