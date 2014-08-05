# File search_catalog.rb
class SearchCatalog
  attr_accessor :columns

  def initialize(search_columns=[])
    self.columns = search_columns
    search_columns.each do |column|
      self.class.class_eval do
        define_method "search_#{column}" do |catalog, *args|
          catalog.select do |k, v|
            if k.to_s == column.to_s
              v.to_s.include?(args.each(&:to_s))
            end
          end
        end
      end
    end
  end

  def search(catalog, *terms)
    catalog.select do |k, v|
      terms.each{|term| v.to_s.include?(term[0])}
      end
  end

  # private
  # def search_size(catalog, *terms)
  #
  # end

end