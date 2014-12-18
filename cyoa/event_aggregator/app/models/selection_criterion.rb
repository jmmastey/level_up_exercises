class SelectionCriterion < ActiveRecord::Base
  has_and_belongs_to_many :feeds

  serialize :configuration, JSON

  protected

  def generate_where_clause 
    implementation_strategy.generate_sql(configuration)
  end

  def implementation_strategy
    @implementation_strategy ||= Object.get_const(implementation_class).new
  end
end
