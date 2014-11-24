class PageDecorator < PartialDecorator
  delegate_all

  def number
    position
  end

  def next_link
    if lower_item.nil?
      { text: 'Finish lesson!', path: course }
    else
      { text: activity.decorate.next_page_text, path: lower_item }
    end
  end
end
