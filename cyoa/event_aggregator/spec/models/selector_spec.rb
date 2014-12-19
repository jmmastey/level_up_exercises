require "rails_helper"

RSpec.describe Selector::Comparator do
  let(:comparator) { FactoryGirl.build(:selector_comparator) }

  it "has a field name" do
    expect(comparator.field).not_to be_nil
  end
 
  it "accepts a field name" do
    comparator.field = "foo"
    expect(comparator.field).to eq("foo")
  end

  it "has a SQL operator" do
    expect(comparator.sql_operator).not_to be_nil
  end

  it "accepts a SQL operator" do
    comparator.sql_operator = "="
    expect(comparator.sql_operator).to eq('=')
  end

  it "has a criterion value" do
    expect(comparator.criterion).not_to be_nil
  end

  it "accepts a criterion value" do
    comparator.criterion = 9
    expect(comparator.criterion).to eq(9)
  end

  it "accepts a configuration hash" do
    config = {}
    comparator.with_configuration(config)
    expect(comparator.configuration).to be(config)
  end

  it "supplies its configuration in the given hash" do
    config = {}
    comparator.with_configuration(config)
    comparator.field = "foo"
    comparator.sql_operator = "!="
    comparator.criterion = "fire"
    expect(config).to eq({
                           :field => 'foo',
                           :sql_operator => '!=',
                           :criterion => 'fire',
                        })
  end
end
