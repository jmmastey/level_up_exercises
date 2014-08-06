# File search_catalog.rb


class SearchCatalog
  attr_accessor :columns

  def initialize(search_columns=[])
    extend Hirb::Console
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

  def search(catalog, terms)

  end

  def show_info(catalog, *terms)
    selected = catalog.select do |k, v|
      terms.include?(v.name)
    end.each {|key, value| value}
  end

  # private
  # def search_size(catalog, *terms)
  #
  # end

end