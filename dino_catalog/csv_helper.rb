module CSVHelper
  CSV::Converters[:blank_to_nil] = lambda do |field|
    field && field.empty? ? nil : field
  end

  def self.load_csv(filename)
    f = File.open(filename, "r")
    data = CSV.new(f, :headers => true, :header_converters => :symbol,
                   :converters => [:all, :blank_to_nil])
    data.to_a.map(&:to_hash)
  end
end