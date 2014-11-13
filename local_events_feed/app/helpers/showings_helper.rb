module ShowingsHelper
  def Showing.one_day_only?(showings)
    return false unless showings.present?
    sorted = Showing.sort_by_time(showings)
    sorted.first.time == sorted.last.time
  end
end
