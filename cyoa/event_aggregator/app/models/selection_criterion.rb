class SelectionCriterion < ActiveRecord::Base
  belongs_to :feed

  after_initialize { self.configuration ||= {} }

  serialize :configuration, JSON
  serialize :sql_expression, JSON

  def sql_expression
    refresh_sql_expression
    super
  end

  def sql_expression_as_clause
    expr = sql_expression
    class_eval { sanitize_sql_array(expr) }
  end

  def implementation_strategy
    @implementation_strategy ||= create_my_implementation
  end

  protected

  def refresh_sql_expression
    self.sql_expression = generate_where_clause
  end

  def generate_where_clause
    implementation_strategy.sql_fragment
  end

  private

  def create_my_implementation
    klass = Object.const_get(implementation_class)
    klass.new.using_configuration_source(self)
  end

  def method_missing(method, *args, &block)
    super
  rescue
    if implementation_strategy.respond_to?(method)
      implementation_strategy.send(method, *args, &block)
    else
      super
    end
  end
end
