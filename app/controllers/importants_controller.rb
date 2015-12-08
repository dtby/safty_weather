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
    mappings = {"lon" => "lng", "lat" => "lat", "data" => "count"}
    #测试代码，本地数据
    rains = ActiveSupport::JSON.decode($redis.get("rain"))["data"].reject{|x| x['data'] == 0}
    #正式代码，无数据
    #rains = Weather.get_rain_data["data"].reject{|x| x['data'] == 0}
    arr = []
    rains.each do |obj|
      ps = ActiveSupport::JSON.decode(obj.to_json)
      arr.push Hash[ps.map {|k, v| [mappings[k], v] }]
    end
    p arr
    p "xxxxxxxxx"
    @points = arr.reject{|x| x['count'] == 0}
    gon.points = @points.to_json
    p @points.to_json
    # @points = Weather.get_rain_data["data"]
    # gon.points = @points.to_json
    #qpf_info = Weather.get_qpf_data(params[:lng], params[:lat])
    qpf_info = {"code"=>1, "msg"=>"", "data"=>{"start_time"=>"2015-12-02 14:18", "list"=>[{"index"=>0, "d"=>"0.0"}, {"index"=>6, "d"=>"0.0"}, {"index"=>12, "d"=>"0.0"}, {"index"=>18, "d"=>"0.0"}, {"index"=>24, "d"=>"0.0"}, {"index"=>30, "d"=>"0.0"}, {"index"=>36, "d"=>"0.0"}, {"index"=>42, "d"=>"0.0"}, {"index"=>48, "d"=>"0.0"}, {"index"=>54, "d"=>"0.0"}, {"index"=>60, "d"=>"0.0"}, {"index"=>66, "d"=>"0.0"}, {"index"=>72, "d"=>"0.0"}, {"index"=>78, "d"=>"0.0"}, {"index"=>84, "d"=>"0.0"}, {"index"=>90, "d"=>"0.0"}]}}
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
    @typhoons_data = typhoons_info['data'].reject{|x| x['lastreporttime'] <= Time.now-1.month}

    #单个台风
    @typhoon_recorder = Weather.get_typhoon_data(@typhoons_data[0]['typhoonid'])['data']
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