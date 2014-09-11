# File search_catalog.rb
require 'optparse'
# SEARCH CATALOG CLASS USED TO SEARCH CATALOG ENTRIES
class SearchCatalog
  attr_accessor :columns, :options

  HELP_TEXT = <<HELP_TEXT
  ----------------------------------------
Search Options:
You can type --help at any point to see this prompt

You can search by:  text, column name, keywords,
                    or a comma delimited search using a combination

Text Search:	      Done by wrapping any string in single or double quotes.

    Usage:	'jurassic' or 'heavy'
    --Or a comma separated list of values and phrases
    Usage:	'Largest known, biped'

Keyword search:	Done using keywords, (no quotes)

    Usage:	big or small

Column search:	Works by taking a column name from the list
                and appending an equal (=) sign

    Usage:	period=Jurassic or name=Abrictasaurus

You can also: Chain these commands to search by keywords
              and column names, by comma separating them:

    Usage:	big, period=Jurassic, 'hunter'
    Usage:	name=Diplocaulus, period=Jurassic

    Note:	This chaining use filters the results of the previous command
          into the next

    *The above usage would produce*
    **BIG item FROM the Jurassic period that ARE hunters*&
HELP_TEXT

  def initialize(search_columns = [])
    extend Hirb::Console
    self.columns = search_columns
    self.options = []
    define_column_methods
  end

  def define_column_methods
    columns.each do |column|
      self.class.class_eval do
        define_method "search_#{column.downcase}" do |catalog, *args|
          catalog.select do |k, v|
            filter_catalog(k, v, args)
          end
        end
      end
    end
  end

  def filter_catalog(_k, v, *args)
    val    = false
    values = v.method("#{column.downcase}").call
    args.each { |arg| val = values.to_s.include?(arg) }
    val
  end

  def big(catalog)
    catalog.select do |_k, v|
      v.weight.to_i > 2000
    end
  end

  def small(catalog)
    catalog.select do |_k, v|
      v.weight.to_i <= 2000
    end
  end

  def search(catalog, terms)
    search_catalog  = catalog.dup
    catalog_options = get_options(terms)
    unless catalog_options.empty?
      catalog_options.each do |option|
        case option
        when Array
          option.each do |opt|
            case opt
            when Symbol
              search_catalog = method(opt).call(search_catalog)
            else
              search_catalog = search_text(search_catalog, opt)
            end
          end
        when Hash
          option.each do |k, v|
            search_catalog = method("search_#{k}").call(search_catalog, v)
          end
        else
        end
      end
      search_catalog
    end
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
      text    = text_search?(term, index)
      keyword = nil
      keyword = keyword?(term, index) unless text
      argument?(term, index) unless keyword || text
    end
    options
  end

  def add_to_options(option, index)
    options[index] = option
  end

  def argument?(term, index)
    if term.downcase.include?('=')
      arguments                = {}
      k, v                     = term.split('=')
      arguments[k.delete(' ')] = v
      add_to_options(arguments, index)
      true
    else
      false
    end
  end

  def text_search?(term, index)
    match = match_text_search(term)
    if match
      # text_search = []
      full_text_search = []
      new_terms        = term.to_s.delete("'").delete('"')
      full_text_search << new_terms.strip
      # text_search << new_terms.split(' ')
      add_to_options(full_text_search, index)
      true
    else
      false
    end
  end

  def match_text_search(term)
    term.to_s.match(/[^'"].*['"]/)
  end

  def keyword?(term, index)
    if term.include?('big' || 'small')
      keywords = []
      keywords << term.to_sym
      add_to_options(keywords, index)
      true
    else
      false
    end
  end

  def show_info(catalog, *terms)
    catalog.select { |_k, v| terms.include?(v) }
  end

  def search_help
    HELP_TEXT
  end
end
