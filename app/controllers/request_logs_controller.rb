class RequestLogsController < ApplicationController
  def index
    @request_logs = RequestLog.all.preload(:response_template).order(created_at: :desc).limit(1000)
  end

  def show
    @request_log = RequestLog.find(params[:id])
  end
end
