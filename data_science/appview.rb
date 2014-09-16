
class AppView
  def dataset_message(dataset)
    dataset.to_s
  end

  def interval_table(intervals)
    rows = intervals.map(&:to_s)
    rows.join("\n")
  end

  def chi_square_results(chi_square)
    chi_square.to_s
  end
end
