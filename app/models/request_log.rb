class RequestLog < ApplicationRecord
  belongs_to :response_template, optional: true
end
