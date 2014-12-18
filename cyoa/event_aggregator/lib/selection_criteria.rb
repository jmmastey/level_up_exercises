require "active_support"

module SelectionCriteria
  extend ActiveSupport::Concern

  SelectionCriteriaError = Class.new(StandardError)
  SelectionCriteriaExpressionError = Class.new(SelectionCriteriaError)

  AVAILABLE_SELECTORS = Set.new

  included do
    AVAILABLE_SELECTORS << self

    def self.config_variable(*var_names)
      var_names.each do |var|
        define_method(var) { self.configuration[var] }
        define_method("#{var.to_s}=") { |val| self.configuration[var] = val }
      end
    end
  end

  def self.all_criteria
    AVAILABLE_SELECTORS.to_a
  end

  def self.create_selector_from_expression(expression)
    AVAILABLE_SELECTORS.each do |selector|
      try_create_selector(selector, expression) do |new_selector|
        return new_selector
      end
    end

    raise SelectionCriteriaExpressionError, "Expression translation failure"
  end

  def self.try_create_selector(selector, expression)
    yield selector.parse_expression(expression)
  rescue
    # This expression does not apply to this selector
  end

  attr_accessor :configuration

  def configuration
    @configuration ||= {}
  end

  def parse_expression(expression)
    raise NotImplementedError,
          "#{self.class.name}::#{__method__}: including class must implement" 
  end

  def generate_sql(configuration)
    raise NotImplementedError,
          "#{self.class.name}::#{__method__}: including class must implement" 
  end
end
