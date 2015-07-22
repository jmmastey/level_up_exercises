require 'spec_helper'
require 'data_science'

describe DataScience do
  it "outputs to std_out" do
    expect { subject.report }.to output.to_stdout
  end
end
