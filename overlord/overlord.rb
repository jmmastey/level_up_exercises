require 'json'
require 'sinatra/base'
require_relative 'lib/bomb'
require_relative 'lib/timer'

class Overlord < Sinatra::Base
  enable :sessions

  helpers do
    def prepare_bomb(activate_code, disarm_code)
      bomb = Bomb.new(activate_code, disarm_code)
      bomb.wires = WireBundle.new(3, 2)
      bomb
    end

    def status_hash(bomb)
      clock = bomb.timer ? bomb.timer.seconds_remaining : ""

      { state: bomb.state.to_s,
        clock: clock,
        error: bomb.error.to_s }
    end
  end

  before do
    @activate_code = "1234"
    @disarm_code = "0000"
    session[:bomb] ||= prepare_bomb(@activate_code, @disarm_code)
    @bomb = session[:bomb]
  end

  get '/' do
    session[:bomb] = prepare_bomb(@activate_code, @disarm_code)
    @bomb = session[:bomb]
    erb :bomb
  end

  get '/BOMB/v1/' do
    content_type :json
    status_hash(@bomb).to_json
  end

  post '/BOMB/v1/' do
    content_type :json

    @bomb.enter_code(params[:code])
    @bomb.timer = nil unless @bomb.active?
    status_hash(@bomb).to_json
  end

  post '/BOMB/v1/trigger' do
    @bomb.timer ||= Timer.new(600) if @bomb.active?

    content_type :json
    status_hash(@bomb).to_json
  end

  get '/BOMB/v1/wires' do
    content_type :json

    wires = @bomb.wires.wires.each_with_index.map do |wire, i|
      { type: wire.type,
        intact: wire.intact?,
        index: i }
    end
    wires.to_json
  end

  post '/BOMB/v1/wire/cut' do
    content_type :json

    return { error: "Invalid Wire Selected" }.to_json unless params[:index]
    return { error: "Bomb is wireless" }.to_json unless @bomb.wires.wires

    @bomb.wires.wires[params[:index].to_i].cut
    status_hash(@bomb).to_json
  end

  post '/BOMB/v1/short' do
    @bomb.enter_code(@activate_code)
    @bomb.timer = Timer.new(1)

    content_type :json
    status_hash(@bomb).to_json
  end

  run! if app_file == $PROGRAM_NAME
end
