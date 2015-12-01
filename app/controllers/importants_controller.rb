class ImportantsController < ApplicationController
  def index
    warning_info = Weather.get_warning_data
    @warning_data = warning_info['data']
  end

  def get_by_unit
    warning_info = Weather.get_warning_data
    @warning_data = warning_info['data']
    #区县预警
    area_warning_info = Weather.get_area_warning_data(params[:unit])
    @area_warning_data = area_warning_info['data']
    respond_to do |format|
      format.js
    end
  end

  #未来降水
  def future
    #@points = FileParse.parse_all.reject{|x| x['count'] == 0.0}
    #@points = FileParse.parse_all
    @points = [{ "lng"=>121.24, "lat"=>31.4, "count"=>0.8},{ "lng"=>121.24, "lat"=>31.4, "count"=>0.0}]
    gon.points = @points.to_json
    # gon.points = @points.to_json
  end

  #台风路径
  def routing
    #台风列表
    typhoons_info = Weather.get_typhoons_data
    #显示lastreporttime >= 当前时间减去一天的台风
    @typhoons_data = typhoons_info['data'].reject{|x| x['lastreporttime'] <= Time.now-1.month}

    #单个台风
    @typhoon_recorder = Weather.get_typhoon_data(@typhoons_data[0]['typhoonid'])['data']
    #@typhoon_recorders = @typhoon_recorder.to_json
  end

  #单个台风
  def get_typhoon
    @typhoon_recorder = Weather.get_typhoon_data(params[:typhoonid])['data']
    #gon.typhoon_recorder = @typhoon_recorder.to_json
    respond_to do |format|
      format.js
    end
  end
end