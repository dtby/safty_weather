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

  def get_warning
    @warning_data = params[:data]
  end

  #未来降水
  def future
    mappings = {"lon" => "lng", "lat" => "lat", "data" => "count"}
    rains = Weather.get_rain_data["data"].reject{|x| x['data'] == 0}
    arr = []
    rains.each do |obj|
      ps = ActiveSupport::JSON.decode(obj.to_json)
      arr.push Hash[ps.map {|k, v| [mappings[k], v] }]
    end
    @points = arr.reject{|x| x['count'] == 0}
    gon.points = @points.to_json

    #获取时间段内的数据
    unless params[:lng].present? && params[:lat].present?
      qpf_info = Weather.get_qpf_data(121.48, 31.22)
    else
      qpf_info = Weather.get_qpf_data(params[:lng], params[:lat])
    end
    @qpf_data = qpf_info["data"]["list"]
  end

  def get_rain
    qpf_info = Weather.get_qpf_data(params[:lng], params[:lat])
    @qpf_data = qpf_info['data']['list']
    p @qpf_data
    respond_to do |format|
      format.js
    end
  end

  #台风路径
  def routing
    #台风列表
    typhoons_info = Weather.get_typhoons_data
    #显示lastreporttime >= 当前时间减去一天的台风
    @typhoons_data = typhoons_info['data'].reject{|x| x['lastreporttime'] <= Time.now-2.month}

    #单个台风,获取单个台风[路径]数据列表的第一个，待确认
    @typhoon_recorder = Weather.get_typhoon_data(@typhoons_data[0]['typhoonid'])['data'][-1]

    @typhoon_recorders = Weather.get_typhoon_data(@typhoons_data[0]['typhoonid'])['data']
    gon.typhoon_recorder = @typhoon_recorder.to_json
    gon.typhoon_recorders = @typhoon_recorders.to_json
  end

  def get_typhoon
    #单个台风
    @typhoon_recorder = Weather.get_typhoon_data(params[:typhoonid])['data'][-1]

    #台风列表
    @typhoon_recorders = Weather.get_typhoon_data(params[:typhoonid])['data']
    gon.typhoon_recorder = @typhoon_recorder.to_json
    gon.typhoon_recorders = @typhoon_recorders.to_json
    #gon.typhoon_recorder = @typhoon_recorder.to_json
    respond_to do |format|
      format.js
    end
  end
end