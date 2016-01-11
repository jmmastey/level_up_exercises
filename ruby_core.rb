#!/usr/bin/env ruby

require 'rspec'

module Stringswap
  def self.swap(string_in, target_match, replacement)
    string_in.sub(/#{target_match}/, replacement)
  end
end

RSpec.describe "testing" do
  it "swaps out one character for another" do
    string_in = "abcdefg"
    target_match = "a"
    replacement = "z"
    string_out = "zbcdefg"

    expect(Stringswap.swap(string_in, target_match, replacement)).to eq(string_out)
  end

  it "swaps out many characters" do
    string_in = "The time has come the walrus said"
    target_match = "the walrus said"
    replacement = "for all good men"
    string_out = "The time has come for all good men"

    expect(Stringswap.swap(string_in, target_match, replacement)).to eq(string_out)
  end
end
