class CustomizedResponseService
  def self.response_for(request)
    rules = ResponseRule.where('path ilike ?', request.path)

    request_body = begin
      JSON.parse(request.body.read)
    rescue JSON::ParserError
      return error('Not a valid json')
    end

    rules = rules.to_a.select { |rule| check(rule, request_body) }

    return error('Not found mapping for %s', request.path) if rules.empty?
    return error('Found too many mappings for %s', request.path) if rules.size > 1

    rule = rules.first
    template = rule.response_template

    sleep(rule.sleep) if rule.sleep.present?
    raise '500 response requested' if rule.raise_error

    body = template.body.gsub(/%([^%]+)%/) do |x| 
      dig_index = parse_dig_index(x[1..-2])
      request_body.dig(*dig_index)
    end

    { json: body, status: rule.response_code }
  end

  def self.error(text, params={})
    {
      json:
      {
        error: format(text, params)
      }
    }
  end

  def self.parse_dig_index(value)
    value.split(',').map { |v| try_to_i(v) }
  end

  def self.try_to_i(value)
    value.to_i.to_s == value ? value.to_i : value
  end

  def self.check(rule, request_body)
    return true if rule.conditions.blank?

    rule.conditions.split("\n").map(&:strip).all? do |condition|
      next if condition.blank?
      values = condition.split('=')
      predicate = values[0]
      expected_value = values[1]
      dig_index = parse_dig_index(predicate)
      value = request_body.dig(*dig_index)

      value.to_s == expected_value
    end 
  end
end
