require "rails_helper"
require_relative "../../../lib/locu-client/locu"

describe Locu::Client do
  let(:api_key) { "Mock Key" }
  let(:client) { described_class.new(api_key) }

  it "is initialized with an API key" do
    expect { client }.not_to raise_error
  end
end
