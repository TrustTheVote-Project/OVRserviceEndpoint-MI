module BasicAuth
  extend ActiveSupport::Concern

  included do
    before_action :basic_auth
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username_value = ENV.fetch('basic_auth_user', 'foo')
      password_value = ENV.fetch('basic_auth_password', 'bar')

      username == username_value && password == password_value
    end
  end
end
