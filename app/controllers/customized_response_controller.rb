class CustomizedResponseController < ApplicationController
  skip_before_action :verify_authenticity_token

  def get
    error = nil
    response = {}
    begin
      response = CustomizedResponseService.response_for(request)
      raise '500 response requested' if response[:raise_error]
      render response[:payload].dup
    rescue StandardError => e
      error = e
      raise
    ensure
      RequestLog.create!(
        request_path: request.path,
        request_body: request.body.read,
        response_code: response.dig(:payload, :status),
        response_body: response.dig(:payload, :json),
        success: response.dig(:success),
        response_template_id: response.dig(:response_template_id),
        error_text: error ? "#{error.class.name}: #{error.message}" : nil,
      )
    end
  end
end
