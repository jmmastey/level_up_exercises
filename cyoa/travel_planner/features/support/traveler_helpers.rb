module TravelerHelpers
  def fill_in_datetime_select(field, value)
    select(value.year,   from: "#{field}_1i")
    select(Date::MONTHNAMES[value.month],  from: "#{field}_2i")
    select(value.day, from: "#{field}_3i")
    select(sprintf("%02d", value.hour), from: "#{field}_4i")
    select(sprintf("%02d", value.min), from: "#{field}_5i")
  end
end
