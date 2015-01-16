module ApplicationHelper
  def readable_date(date_or_time)
    date = Date.parse(date_or_time.to_s)
    date.to_s(:long)
  end

  def pagination_wrapper_for(collection)
    content_tag(:div, class: 'pagination-wrapper') do
      concat content_tag(:div, paginate(collection), class: 'pagination-links')
      concat content_tag(:div, page_entries_info(collection), class: 'page-entries-info')
    end
  end

  def strip_http(url)
    return '' if url.nil?
    return url.sub!(/http(s*)\:\/\//, '')
  end
end
