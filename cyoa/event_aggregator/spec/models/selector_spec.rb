require "rails_helper"
require "ostruct"

RSpec.describe Selector::Comparator do
  let(:comparator) { FactoryGirl.build(:selector_comparator) }
  let(:config_source) { OpenStruct.new(configuration: {}) }

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

  it "accepts a configuration source" do
    comparator.using_configuration_source(config_source)
    expect(comparator.config_source).to be(config_source)
  end

  it "supplies its configuration in the given hash" do
    comparator.using_configuration_source(config_source)
    comparator.field = "foo"
    comparator.sql_operator = "!="
    comparator.criterion = "fire"
    expect(config_source.configuration).to eq({
                           'field' => 'foo',
                           'sql_operator' => '!=',
                           'criterion' => 'fire',
                        })
  end
end
