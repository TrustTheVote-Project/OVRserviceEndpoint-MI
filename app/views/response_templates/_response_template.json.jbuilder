json.extract! response_template, :id, :name, :body, :created_at, :updated_at
json.url response_template_url(response_template, format: :json)
