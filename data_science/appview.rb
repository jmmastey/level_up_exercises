
class ApplicationView
  def dataset_message(dataset)
    [dataset.to_s, groups_message(dataset.groups)].join("\n")
  end

  def groups_message(groups)
    group_messages = groups.map do |group_id, group|
      "Group '#{group_id}' results: #{group}"
    end
    group_messages.join("\n")
  end

  def interval_table(dataset)
    dataset.groups.map do |group_id, data_group|
      "Group #{group_id}: #{data_group.to_conf}"
    end.join("\n")
  end

  def chi_squared_results(chi_square)
    chi_square.to_s
  end
end
