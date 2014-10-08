require_relative "spec_helper"
require_relative "../lib/eve_central/marketstat.rb"

describe EveCentral::Marketstat do
  let(:api_url) { "http://api.eve-central.com/api/marketstat" }
  let(:custom_url) { "http://api.eve-central.com/api/alt-marketstat" }
  let(:marketstat) { EveCentral::Marketstat.new }
  let(:custom_marketstat) { EveCentral::Marketstat.new(custom_url) }

  it "can be initialized with no parameters" do
    expect(marketstat).not_to be nil
  end

  it "defaults to using 'http://api.eve-central.com/api/marketstat' as the API URL" do
    expect(marketstat.url).to eq(api_url)
  end

  it "can be initialized with a custom API URL" do
    expect(custom_marketstat.url).to eq(custom_url)
  end
end
