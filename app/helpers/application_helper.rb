module ApplicationHelper

  def baidu_api(key)
    "http://api.map.baidu.com/api?v=2.0&ak=" + key.to_s
  end

  # 根据日期获取周几
  def get_weekday datatime
    date = datatime.to_datetime
    if date.sunday?
      "星期日"
    elsif date.monday?
      "星期一"
    elsif date.tuesday?
      "星期二"
    elsif date.wednesday?
      "星期三"
    elsif date.thursday?
      "星期四"
    elsif date.friday?
      "星期五"
    elsif date.saturday?
      "星期六"
    end
  end

end
