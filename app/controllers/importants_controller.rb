class ImportantsController < ApplicationController
  def index
    warning_info = Weather.get_warning_data
    @warning_data = warning_info['data']
  end

  #未来降水
  def future
  end

  #台风路径
  def routing
  end
end