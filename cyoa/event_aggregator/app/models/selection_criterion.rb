class SelectionCriterion < ActiveRecord::Base
  has_and_belongs_to_many :feeds

  before_save :refresh_sql_expression

  serialize :configuration, JSON

  protected

  def refresh_sql_clause
    sql_expression = generate_where_clause
  end

  def generate_where_clause 
    implementation_strategy.generate_sql(configuration)
  end

  def implementation_strategy
    @implementation_strategy ||= Object.get_const(implementation_class).new
  end
end
