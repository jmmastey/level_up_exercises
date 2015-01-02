module DeviseHelper
  def devise_error_messages!
    return "" if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:label, msg, class: "label-error") }.join
    sentence = I18n.t("errors.messages.not_saved",
                      :count => resource.errors.count,
                      :resource => resource.class.model_name.human.downcase)

    html = <<-HTML
    <div class="errors">
      <header>
        <p>The #{resource.class.model_name.human.downcase} could not be saved.</p>
        <p>Please correct the #{pluralize(resource.errors.count, 'error')} below:</p>
      </header>
      <p>#{messages}</p>
    </div>
    HTML

    html.html_safe
  end

  def devise_error_messages?
    resource.errors.empty? ? false : true
  end
end
