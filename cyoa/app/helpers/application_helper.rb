module ApplicationHelper
  def header_text
    bill_class, legislator_class = set_classes
    content_tag(:span) do
      concat 'Search'
      concat link_to 'Bills', '#', class: bill_class
      concat ' | '
      concat link_to 'Legislators', '#', class: legislator_class
      concat 'for'
    end
  end

  private

  def set_classes
    classes = 'waves-effect waves-light btn query-filter red'
    active_class = "#{classes} active"
    disabled_class = "#{classes} disabled"

    if params[:controller] == 'legislators'
      bill_class = disabled_class
      legislator_class = active_class
    else
      bill_class = active_class
      legislator_class = disabled_class
    end
    [bill_class, legislator_class]
  end
end
