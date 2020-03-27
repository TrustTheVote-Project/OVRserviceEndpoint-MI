json.extract! response_rule, :id, :name, :path, :response_template_id, :response_code, :conditions, :sleep, :raise_error, :created_at, :updated_at
json.url response_rule_url(response_rule, format: :json)
