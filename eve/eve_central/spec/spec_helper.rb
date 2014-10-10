require "rspec/collection_matchers"
require "vcr"

RSpec.shared_context "item_ids" do
  let(:tritanium_id) { 34 }
  let(:tritanium_name) { "Tritanium" }
  let(:pyerite_id) { 35 }
  let(:pyerite_name) { "Pyerite" }
end

RSpec.shared_context "station_ids" do
  let(:amarr6_tct_id) { 60008950 }
  let(:amarr6_tct_name) { "Amarr VI (Zorast) - Moon 2 - Theology Council Tribunal" }
  let(:amarr8_efa_id) { 60008494 }
  let(:amarr8_efa_name) { "Amarr VIII (Oris) - Emperor Family Academy" }
end

VCR.configure do |c|
  c.cassette_library_dir = "vcr/cassettes"
  c.hook_into :webmock
end
