require 'spec_helper'
require 'rspec/collection_matchers'
require_relative '../respond'

describe Respond do
  let(:respond) { respond = Respond.new('bomb_responses.json') }

  it 'should load all responses' do
    expect(respond).to have(11).responses
  end
  
  it 'should respond with the correct message' do
    expect(respond.with(:already_active)).to eq('Bomb is already active')
  end
end
