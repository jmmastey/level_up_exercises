module CustomSelect
  def select_without(*columns_to_exclude)
    columns = column_names.map(&:to_sym)
    select(columns - columns_to_exclude)
  end
end
