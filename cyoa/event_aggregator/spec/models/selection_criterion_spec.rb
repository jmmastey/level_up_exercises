require 'rails_helper'

RSpec.describe SelectionCriterion, :type => :model do
  let(:criterion) { FactoryGirl.create(:selection_criterion) }

  it "has an implementation (selector) class" do
    expect(criterion.implementation_class).not_to be_nil
  end

  it "creates its implementation (selector instance)" do
    actual_class = criterion.implementation_strategy.class.name
    expect(actual_class).to eq(criterion.implementation_class)
  end

  it "has a configuration" do
    expect(criterion.configuration).not_to be_nil
  end

  it "shares its configuration with its selector implementation" do
    selector = criterion.implementation_strategy
    selector.field = "bessy"
    expect(criterion.configuration["field"]).to eq("bessy")
  end

  it "creates its SQL expression" do
    criterion.criterion = 5
    expected = ['"start_time" > ?', 5]
    expect(criterion.sql_expression).to eq(expected)
  end
end
