class DinosaurQuery
  attr_accessor :dinosaurs, :filtered, :query, :criteria

  def initialize(dinosaurs)
    @dinosaurs = dinosaurs
    @criteria = {}
    @filtered = []
  end

  def process
    filter_criteria
    filtered
  end

  private

  def normalize_query
    query.squeeze!(' ')
  end

  def filter_criteria
    print "Enter your query (sql style)\n> "
    @query = gets.chomp!
    normalize_query
    process_query
  end

  def process_query
    parts = query.split(/\s(?=(?:[^"]|"[^"]*")*$)/)
    return if parts.length < 3
    return run_single_query(parts) if parts.length == 3
    run_multiple_queries(parts)
  end

  def run_single_query(parts)
    criteria[:key] = parts[0]
    criteria[:filter] = parts[1]
    criteria[:value] = parts[2].gsub(/\"/, '')
    run_criteria
  end

  def run_multiple_queries(parts)
    parts.each_with_index do |part, index|
      build_criteria(part, index)
      run_criteria if index % 4 == 3
    end
  end

  def run_criteria
    results = run_query_part
    results.each do |dinosaur|
      filtered << dinosaur unless filtered.include?(dinosaur)
    end
  end

  def run_query_part
    puts criteria
    case criteria[:filter]
      when '>'
        dinosaurs.select { |d| d.greater_than?(criteria[:key], criteria[:value]) }
      when '<'
        dinosaurs.select { |d| d.less_than?(criteria[:key], criteria[:value]) }
      when '='
        dinosaurs.select { |d| d.filter(criteria[:key], criteria[:value]) }
      when 'eq'
        dinosaurs.select { |d| d.contains(criteria[:key], criteria[:value]) }
      when '!='
        dinosaurs.select { |d| !d.filter(criteria[:key], criteria[:value]) }
      when 'ne'
        dinosaurs.select { |d| !d.contains(criteria[:key], criteria[:value]) }
    end
  end

  def build_criteria(part, index)
    index = index % 4
    @criteria[:key] = part if index == 0
    @criteria[:filter] = part if index == 1
    @criteria[:value] = part.gsub(/\"/, '') if index == 2
  end
end
