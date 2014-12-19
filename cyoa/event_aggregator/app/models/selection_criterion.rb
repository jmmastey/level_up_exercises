class SelectionCriterion < ActiveRecord::Base
  has_and_belongs_to_many :feeds

  before_save :refresh_sql_expression

  serialize :configuration, JSON

  def implementation_strategy
    @implementation_strategy ||= create_my_implementation
  end

  protected

  def refresh_sql_expression
    sql_expression = generate_where_clause
  end

  def generate_where_clause 
    implementation_strategy.generate_sql_fragment
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
      implementation_strategy.send(method, *args, block)
    else
      super
    end
  end
end
