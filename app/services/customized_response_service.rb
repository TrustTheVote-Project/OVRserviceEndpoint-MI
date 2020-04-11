class CustomizedResponseService
  def self.response_for(request)
    rules = ResponseRule.where('path ilike ?', request.path)

    request_body = begin
      JSON.parse(request.body.read.presence || '{}')
    rescue JSON::ParserError
      return error('Not a valid json')
    end

    rules = rules.to_a.select { |rule| check(rule, request_body) }
    return error('Not found mapping for %s', request.path) if rules.empty?

    rules.reject! { |rule| rule.conditions.blank? }  if rules.size > 1
    return error('Found too many mappings for %s ', request.path) if rules.size > 1

    rule = rules.first
    template = rule.response_template

    sleep(rule.sleep) if rule.sleep.present?
    
    body = if rule.raise_error
      nil
    else
      template.body.gsub(/%([^%]+)%/) do |x| 
        dig_index = parse_dig_index(x[1..-2])
        request_body.dig(*dig_index)
      end
    end

    {
      success: true,
      raise_error: rule.raise_error,
      response_template_id: template.id,
      payload: { 
        json: body, status: rule.response_code 
      }
    }
  end

  def self.error(text, params={})
    {
      success: false,
      payload: {
        json:
        {
          error: format(text, params)
        }
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
      values = condition.split(/(\!?=)/)
      predicate = values[0]
      operator = values[1]
      expected_value = values[2]
      dig_index = parse_dig_index(predicate)
      value = request_body.dig(*dig_index)

      if operator == '='
        value.to_s == expected_value
      else # operator == '!='
        value.to_s != expected_value
      end
    end 
  end
end
