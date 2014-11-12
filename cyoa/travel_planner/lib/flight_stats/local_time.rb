module LocalTime
  def strip_timezone(dt)
    DateTime.parse(dt.strftime("%FT%T"))
  end
end
