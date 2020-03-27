class CustomizedResponseController < ApplicationController
  skip_before_action :verify_authenticity_token

  def get
    render json: {path: request.path, body: request.body, method: request.method}
  end
end
