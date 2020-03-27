class CustomizedResponseController < ApplicationController
  skip_before_action :verify_authenticity_token

  def get
    render CustomizedResponseService.response_for(request)
  end
end
