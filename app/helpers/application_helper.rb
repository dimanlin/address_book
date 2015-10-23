module ApplicationHelper
  def error_message(obj, field)
    error = obj.errors.messages[field]
    if error.present?
      content_tag('p') do
        content_tag('span', class: 'error_message') do
          error.join(', ')
        end
      end
    end
  end
end
