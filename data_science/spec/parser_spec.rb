require_relative 'spec_helper'
require_relative '../lib/parser'

describe Parser do
  let(:Parser) { Class.new { include Parser } }

  it "parses a JSON file into two cohorts" do
    expect(Parser.new.parse("./source_data.json")[0].class).to eq(Cohort)
    expect(Parser.new.parse("./source_data.json")[1].class).to eq(Cohort)
  end
end
