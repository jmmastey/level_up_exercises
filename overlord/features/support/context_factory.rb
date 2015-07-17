module SitePrism
  module Context
    # Creates a definition context for actions and establishes
    # the context for display.
    #
    # @param definition [Class] the name of the page class
    # @param block [Proc] logic to execute in the context of the definition
    # @return [Object] instance of the page definition
    def on_visit(definition, &block)
      on(definition, true, &block)
    end

    # Creates a definition context for actions.
    #
    # @param definition [Class] the name of the page class
    # @param visit [Boolean] true if the definition needs to be called into view
    # @param block [Proc] logic to execute in the context of the definition
    def on(definition, visit = false, &block)
      unless @page.is_a?(definition)
        @page = definition.new
        @page.load if visit
      end

      block.call @page if block
      @page
    end
  end
end

World(SitePrism::Context)
