module Weather
  HOST = "http://61.152.122.112:8080"
  WEATHER_URL = "/api/v1/weather_forecasts/query?appid=3z9SIrelF7oKLUbVcPa2&appkey=HYC40csnPN3lMbjf7FiSZIKXTu6AUy&city_name=上海"
  AQI_URL = "/api/v1/aqi?appid=3z9SIrelF7oKLUbVcPa2&appkey=HYC40csnPN3lMbjf7FiSZIKXTu6AUy"
  LOCAL_WEATHER_URL = '/api/v1/aqi?appid=3z9SIrelF7oKLUbVcPa2&appkey=HYC40csnPN3lMbjf7FiSZIKXTu6AUy'

  #天气数据
  def self.get_weather_data
    self.get_data_from_url(WEATHER_URL)
  end

  #空气质量数据
  def self.get_aqi_data
    self.get_data_from_url(AQI_URL)
  end

  #通过url获取数据
  def self.get_data_from_url url
    uri = URI.encode(url)
    conn = Faraday.new(:url => HOST) do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end

    response = conn.get do |req|
      req.url uri
      req.headers['Content-Type'] = 'application/json'
      req.headers['Accept'] = 'application/json'
    end
    MultiJson.load response.body
  end

  #获取气象图标
  def self.get_weather_icons text
    results = SyncopateDecorator.process(text)
    weather_list = ["暴雪", "暴雨", "大暴雨", "特大暴雨", "强沙尘暴", "大雪", "大雨",
      "冻雨", "浮尘", "阵雨", "雷阵雨", "沙尘暴", "雾", "小雪","小雨", "扬沙", "阴", 
      "雨夹雪", "中雪", "中雨", "晴", "多云", "冰雹", "阵雪"]
    bg_image_list = {
      "暴雪" => "weather_super_snow.png",
      "暴雨" => "weather_rainstorm.png",
      "大暴雨" => "weather_big_rainstorm.png",
      "特大暴雨" => "weather_super_rainstorm.png",
      "强沙尘暴" => "weather_sandstorm.png",
      "大雪" => "weather_big_snow.png",
      "大雨" => "weather_big_rain.png",
      "冻雨" => "weather_sleet_rain.png",
      "浮尘" => "weather_dust.png",
      "阵雨" => "weather_shower_rain.png",
      "雷阵雨" => "weather_thunder_rain.png",
      "沙尘暴" => "weather_sandstorm.png",
      "雾" => "weather_fog.png",
      "小雪" => "weather_little_snow.png",
      "小雨" => "weather_little_rain.png",
      "扬沙" => "weather_jansa.png",
      "阴" => "weather_overcast.png",
      "雨夹雪" => "weather_sleet.png",
      "中雪" => "weather_mid_snow.png",
      "中雨" => "weather_mid_rain.png",
      "晴" => "weather_sunny.png",
      "多云" => "weather_cloudy.png",
      "冰雹" => "weather_hail.png",
      "阵雪" => "weather_big_snow.png"
    }
    pic = []
    txt = []
    results.each do |idx|
      if weather_list.include?(idx)
        txt << idx
        pic << bg_image_list[idx]
      end
    end
    pic << weathertext if pic.empty?
    txt << weathertext if txt.empty?
    result = Hash.new
    result["pic"] = pic
    result["txt"] = txt

    return result
  end
end