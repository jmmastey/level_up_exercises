require_relative '../bomb.rb'

RSpec.describe Bomb do
  before :example do
    @bomb = Bomb.new
  end

  it 'initializes with empty code sequences' do
    expect(@bomb.activation_code.code).to be_nil
    expect(@bomb.deactivation_code.code).to be_nil
  end

  it 'can set countdown time to custom' do
    time_ms = 5000
    expected_server_time = Time.now
    @bomb.update_countdown_time time_ms
    expect(@bomb.countdown_time).to eq(time_ms)
    expect(@bomb.countdown_start_time).to be_within(100).of(expected_server_time)
  end

  it 'can set countdown time using default' do
    expected_server_time = Time.now
    @bomb.update_countdown_time
    expect(@bomb.countdown_time).to eq(Bomb::DEFAULT_COUNTDOWN_TIME)
    expect(@bomb.countdown_start_time).to be_within(100).of(expected_server_time)
  end

  it 'can set current state' do
    index = 3
    bomb_state_hash = { name: Bomb::STATES[index], index: index }
    @bomb.current_state_index = index
    expect(@bomb.current_state).to eq(bomb_state_hash)
  end
end