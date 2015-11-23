class ImportantsController < ApplicationController
  def index
    warning_info = Weather.get_warning_data
    @warning_data = warning_info['data']
  end

  #未来降水
  def future
    #@points = FileParse.parse_all.reject{|x| x['count'] == 0.0}
    @points = FileParse.parse_all
    gon.points = @points.to_json
    # @points = [{ "lng"=>121.24, "lat"=>31.4, "count"=>0.8},{ "lng"=>121.24, "lat"=>31.4, "count"=>0.0}]
    # gon.points = @points.to_json
  end

  #台风路径
  def routing
  end
end