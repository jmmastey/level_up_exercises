# File wire.rb
class Overlord < Sinatra::Application

  get '/api/wire' do
    wires = Wire.all(:fields => [:id, :color]).map do |wire|
      {color: wire.color, id: wire.id}
    end
    format_response(wires, request.accept)
  end

  get '/api/wire/cut/:id' do
    wires ||= Wire.all(bomb_id: params[:id], :fields => [:id, :color]) || halt(404)
    format_response(wires.map do |wire|
      {color: wire.color, id: wire.id}
    end, request.accept)
  end




end
