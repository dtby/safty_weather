class ImportantsController < ApplicationController
  def index
    warning_info = Weather.get_warning_data
    @warning_data = warning_info['data']
  end

  #未来降水
  def future
    @points = FileParse.parse_all
    gon.points = @points.to_json
    # @points = [
    #   {"lng"=>121.24, "lat"=>31.4, "count"=>0.8},
    #   {"lng"=>121.46, "lat"=>31.4, "count"=>0.8},
    #   {"lng"=>121.24, "lat"=>30.92, "count"=>0.8},
    #   {"lng"=>121.76, "lat"=>31.05, "count"=>0.8},
    #   {"lng"=>121.7, "lat"=>31.19, "count"=>0.8},
    #   {"lng"=>121.48, "lat"=>31.41, "count"=>0.8},
    #   {"lng"=>121.4, "lat"=>31.73, "count"=>0.8},
    #   {"lng"=>121.1, "lat"=>31.15, "count"=>0.8}
    # ]
    # gon.points = @points.to_json
  end

  #台风路径
  def routing
  end
end