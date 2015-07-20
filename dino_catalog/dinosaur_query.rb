class DinosaurQuery
  attr_accessor :dinosaurs, :query, :criteria

  def initialize(dinosaurs)
    @dinosaurs = dinosaurs
    @criteria = {}
  end

  def process
    ask_user_for_criteria
    normalize_query
    process_query
    dinosaurs
  end

  private

  def normalize_query
    query.squeeze!(' ')
  end

  def process_query
    # Split on all spaces except for spaces inside quotes
    parts = query.split(/\s(?=(?:[^"]|"[^"]*")*$)/)
    return if parts.length < 3
    return run_single_query(parts) if parts.length == 3
    run_multiple_queries(parts)
  end

  def run_single_query(parts)
    self.criteria = {
      key: parts[0],
      filter: parts[1],
      value: parts[2].gsub(/\"/, ''),
    }
    run_criteria
  end

  def run_multiple_queries(parts)
    parts.each_with_index do |part, index|
      build_criteria(part, index)
      run_criteria if index % 4 == 2
    end
  end

  def run_criteria
    @dinosaurs = run_query_part
  end

  def run_query_part
    case criteria[:filter]
      when '>'
        dinosaurs.select do |d|
          d.greater_than?(criteria[:key], criteria[:value])
        end
      when '<'
        dinosaurs.select { |d| d.less_than?(criteria[:key], criteria[:value]) }
      when '='
        dinosaurs.select { |d| d.eql?(criteria[:key], criteria[:value]) }
      when 'eq'
        dinosaurs.select { |d| d.contains(criteria[:key], criteria[:value]) }
      when '!='
        dinosaurs.reject { |d| d.eql?(criteria[:key], criteria[:value]) }
      when 'ne'
        dinosaurs.reject { |d| d.contains(criteria[:key], criteria[:value]) }
    end
  end

  def build_criteria(part, index)
    index = index % 4
    @criteria[:key] = part if index == 0
    @criteria[:filter] = part if index == 1
    @criteria[:value] = part.gsub(/\"/, '') if index == 2
  end

  private

  def ask_user_for_criteria
    print "Enter your query \
          (sql style, for example weight > 400 AND diet = Carnivore)\n> "
    @query = gets.chomp!
  end
end
