require_relative "split_test_group"

class DataGrouper
  def create_groups(data_entries)
    grouped_entries = group_entries(data_entries)
    create_test_groups(grouped_entries)
  end

  private

  def create_test_group(cohort, entries)
    num_conversions = count_conversions(entries)
    num_views = count_views(entries)

    SplitTestGroup.new(name: cohort,
                       num_conversions: num_conversions,
                       num_views: num_views)
  end

  def create_test_groups(grouped_entries)
    grouped_entries.map do |cohort, entries|
      create_test_group(cohort, entries)
    end
  end

  def count_conversions(data_entries)
    data_entries.count(&:conversion?)
    # data_entries.count { |entry| entry.conversion? }
  end

  def count_views(data_entries)
    data_entries.count
  end

  def group_entries(data_entries)
    data_entries.group_by(&:cohort)
  end
end
