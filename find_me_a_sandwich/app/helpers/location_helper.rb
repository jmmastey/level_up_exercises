module LocationHelper
  def format_address(location)
    content_tag(:address) do
      lines = location.to_s.lines.map { |l| content_tag(:span, l) }
      lines.join(tag(:br)).html_safe
    end
  end

  def format_user_location(location)
    return nil if location.nil?

    content_tag(:address) do
      content_tag(:span, "#{location.city}, #{location.state}  #{location.zip}")
    end
  end
end
