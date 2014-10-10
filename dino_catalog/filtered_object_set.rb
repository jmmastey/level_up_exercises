# An Enumerable collection of objects that's qualified by a filter condition
module ObjectSet
  class FilteredObjectSet
    include ObjectSet
    
    def initialize(parent, attribute, match_expressions)
      @parent = parent
      @filter_attribute = attribute
      @match_expressions = match_expressions
    end

    # Implements Enumerable
    def each
      @parent.each { |item| yield item if keep_item?(item) }
    end

    private

    def keep_item?(item)
      item.respond_to?(@filter_attribute) && 
        @match_expressions.include?(item.send(@filter_attribute)) 
    end
  end
end
