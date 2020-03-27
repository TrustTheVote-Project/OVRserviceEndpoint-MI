module ApplicationHelper
  def safe_render_json(content)
    return '<empty>' if content.blank?

    json = JSON.parse(content)
    JSON.pretty_generate(json)
  rescue JSON::ParserError
    content
  end
end
