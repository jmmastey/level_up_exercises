module ShowingsHelper
  def self.one_day_only?(showings)
    return false unless showings.present?
    sorted = showings.sorted
    sorted.first.time.to_date == sorted.last.time.to_date
  end

  def self.pretty_date_range(showings)
    return 'No Showings' unless showings.present?
    first_view = ApplicationHelper::LocalTimeView.new(showings.first.time)
    last_view = ApplicationHelper::LocalTimeView.new(showings.last.time)
    return "#{first_view.pretty_date_no_dow} Only" if one_day_only?(showings)
    first_view.pretty_date_no_year + " - " + last_view.pretty_date_no_dow
  end

  def self.pretty_showing_count(showings)
    return 'No Showings' unless showings.present?
    return "#{showings.count} Showing" if showings.count == 1
    "#{showings.count} Showings"
  end
end
