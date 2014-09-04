# File search_catalog.rb
require 'optparse'


class SearchCatalog
  attr_accessor :columns, :options

  def initialize(search_columns=[])
    extend Hirb::Console
    self.columns = search_columns
    self.options = []
    search_columns.each do |column|
      self.class.class_eval do
        define_method "search_#{column.downcase}" do |catalog, *args|
          catalog.select do |k, v|
            val = false
            values = v.method("#{column.downcase}").call
            args.each{|arg| val = values.to_s.include?(arg)}
            val
            end
          end
        end
      end
  end

  def big(catalog)
    catalog.select do |k, v|

        v.weight.to_i > 2000
    end
  end

  def small(catalog)
    catalog.select do |k, v|
        v.weight.to_i <= 2000
    end
  end


  def search(catalog, terms)
    search_catalog = catalog.dup
    get_options(terms).each do |option|
      case option
        when Array
          option.each do |opt|
            case opt
              when Symbol
                search_catalog =  self.method(opt).call(search_catalog)
              else
                search_catalog = search_text(search_catalog, opt)

            end
          end
        when Hash
          option.each do |k, v|
            search_catalog =  self.method("search_#{k}").call(search_catalog, v)
          end
        else

      end
    end
     search_catalog
  end

  def search_text(catalog, opt)
    catalog.select do |k, v|
      result = (k.to_s == opt)
      v.instance_variables.each do |key|
        values = v.instance_variable_get(key)
        result = values.to_s.include?(opt) unless result
      end
      result
    end
  end

  def get_options(terms)
    self.options = []
    terms.split(',').each_with_index do |term, index|
      text = is_text_search?(term, index)
      keyword = nil
      unless text
        keyword = is_keyword?(term, index)
      end
      unless keyword || text
        is_argument?(term, index)
      end
    end
    self.options
  end

  def add_to_options(option, index)
    self.options[index] = option
  end

  def is_argument?(term, index)
    if term.downcase.include?('=')
      arguments = {}
      k, v = term.split('=')
      arguments[k.delete(' ')] = v
      self.add_to_options(arguments, index)
      true
    else
      false
    end
  end

  def is_text_search?(term, index)
    match = match_text_search(term)
    if match
      text_search = []
      full_text_search = []
      new_terms = term.to_s.delete("'").delete('"')
      full_text_search << new_terms.strip
      text_search << new_terms.split(' ')
      self.add_to_options(full_text_search, index)
      true
    else
      false
    end
  end

  def match_text_search(term)
    term.to_s.match(/[^'"].*['"]/)
  end

  def is_keyword?(term, index)
    if term.include? ('big' || 'small')
      keywords = []
      keywords << term.to_sym
      self.add_to_options(keywords, index)
      true
    else
      false
    end

  end


  def search_help
    search_text = '-'*40+"\n"
    search_text += "Search Options: \n"
    search_text += "You can type --help at any point to see this prompt\n\n"
    search_text += "You can search by text, column name, keywords, or a comma delimited search using a combination\n\n"
    search_text += "Text Search:\tDone by wrapping any string in single or double quotes.\n\n"
    search_text += "\t\tUsage:\t'jurassic' or 'heavy'\n"
    search_text += "\t\t--Or a comma separated list of values and phrases\n"
    search_text += "\t\tUsage:\t'Largest known, biped'\n\n"
    search_text += "Keyword search:\tDone using keywords, (no quotes)\n\n"
    search_text += "\t\tUsage:\tbig or small\n\n"
    search_text += "Column search:\tWorks by taking a column name from the list and appending an equal (=) sign\n\n"
    search_text += "\t\tUsage:\tperiod=Jurassic or name=Abrictasaurus\n\n"
    search_text += "You can also chain these commands to search by keywords and column names, by comma separating them:\n\n"
    search_text += "\t\tUsage:\tbig, period=Jurassic, 'hunter' \n"
    search_text += "\t\tUsage:\tname=Diplocaulus, period=Jurassic \n"
    search_text += "\t\tNote:\tThis chaining use filters the results of the previous command into the next\n"
    search_text += "\t\t*The above usage would produce BIG item FROM the Jurassic period that ARE hunters*\n\n\n"

    search_text
  end

  def show_info(catalog, *terms)
    catalog.select { |k, v| terms.include?(v) }
  end

end