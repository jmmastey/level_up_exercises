module FlashHelper
  def flash_panel(notice, alert)
    return unless notice || alert
    color_class = notice ? 'green' : 'red'
    icon_value = notice ? 'done' : 'error'
    content_tag(:div, class: 'row') do
      content_tag(:div, class: %w(col s6 offset-s3)) do
        content_tag(:div, class: ['card-panel', color_class, 'notice']) do
          concat icon(icon_value)
          concat content_tag(:span, notice, class: 'white-text') if notice
          concat content_tag(:span, alert, class: 'white-text') if alert
        end
      end
    end
  end
end
