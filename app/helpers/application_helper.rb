module ApplicationHelper

  def baidu_api
    "http://api.map.baidu.com/api?v=2.0&ak=" + ENV['baidukey']
  end

end
