class SelectionCriterion < ActiveRecord::Base
  has_and_belongs_to_many :feeds

  before_save :refresh_sql_expression

  serialize :configuration, JSON

  protected

  def refresh_sql_expression
    sql_expression = generate_where_clause
  end

  def generate_where_clause 
    implementation_strategy.generate_sql(configuration)
  end

  def implementation_strategy
    @implementation_strategy ||= create_my_implementation
  end

  private

  def create_my_implementation
    klass = Object.get_const(implementation_class)
    klass.new.with_configuration(configuration)
  end
end
