class RequestLogsController < ApplicationController
  def index
    @request_logs = RequestLog.all.preload(:response_template)
  end

  def show
    @request_log = RequestLog.find(params[:id])
  end
end
