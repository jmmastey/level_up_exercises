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

  it 'should respond with the correct message for already_active' do
    expect(respond.with(:already_active)).to eq('Bomb is already active')
  end

  it 'should respond with the correct message for already_inactive' do
    expect(respond.with(:already_inactive)).to eq('Bomb is already inactive')
  end

  it 'should respond with the correct message for activated' do
    expect(respond.with(:activated)).to eq('Bomb activated - Look Out!')
  end

  it 'should respond with the correct message for deactivated' do
    expect(respond.with(:deactivated)).to eq('Bomb deactivated')
  end

  it 'should respond with the correct message for detonation' do
    expect(respond.with(:detonation)).to eq('Bomb has been detonated!')
  end

  it 'should respond with the correct message for just_snipped' do
    expect(respond.with(:just_snipped)).to eq('Bomb wires snipped and is now defunct')
  end

  it 'should respond with the correct message for already_exploded' do
    expect(respond.with(:already_exploded)).to eq('Sorry, bomb has already exploded.')
  end

  it 'should respond with the correct message for already_snipped' do
    expect(respond.with(:already_snipped)).to eq('Sorry, bomb wires have been snipped.')
  end

  it 'should respond with the correct message for too_many_deact' do
    expect(respond.with(:too_many_deact)).to eq('Bomb exploded - too many attempts!')
  end

  it 'should respond with the correct message for wrong_code' do
    expect(respond.with(:wrong_code)).to eq('Wrong code')
  end

  it 'should respond with the correct message for code_not_an_int' do
    expect(respond.with(:code_not_an_int)).to eq('Code must be an integer')
  end

  it 'should keep track of the last reponse' do
    respond.with(:code_not_an_int)
    expect(respond.last).to eq('Code must be an integer')
  end

  it 'should know how to deal with unrecognized messages' do
    expect(respond.with(:what_the_heck)).to eq("Don't know what to say")
  end

  it 'should return unrecognized message when there was no last response' do
    expect(respond.last).to eq("Don't know what to say")
  end
end
