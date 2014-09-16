
class AppView
  def dataset_message(dataset)
    dataset.to_s + "\n" + groups_message(dataset.groups)
  end

  def groups_message(groups)
    group_messages = groups.map do |group_id, group|
      "Group '#{group_id}' results: #{group}"
    end
    group_messages.join("\n")
  end

  def interval_table(intervals_with_id)
    rows = intervals_with_id.map do |interval_with_id|
      "Group '#{interval_with_id[0]}' interval: #{interval_with_id[1]}"
    end
    rows.join("\n")
  end

  def chi_squared_results(chi_square)
    chi_square.to_s
  end
end
