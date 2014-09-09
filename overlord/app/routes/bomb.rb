# File bomb.rb
class Overlord < Sinatra::Application

  get '/api/bomb' do
    bombs = Bomb.all.map do |bomb|
      {id: bomb.id, status: bomb.status, attemps: bomb.attempts,
       detonation_time: bomb.detonation_time}
    end
    format_response(bombs, request.accept)
  end

  get '/api/bomb/:id' do
    bomb ||= Bomb.get(params[:id]) || halt(404)
    wires = bomb.wires.map do |wire|
      {color: wire.color, id: wire.id}
    end
    bomb = {id: bomb.id, status: bomb.status, attemps: bomb.attempts,
       detonation_time: bomb.detonation_time, wires:wires}
    format_response(bomb, request.accept)
  end

  get '/api/bomb/:id/cut/:wire_id' do
    bomb ||= Bomb.get(params[:id]) || halt(404)
    wire ||= bomb.wires.get(params[:wire_id]) || halt(404)

    wire_response = cut_wire_status(wire)
    cut_wire_response(bomb,wire_response.status,
                      wire_response.message , request.accept)
  end

  get '/test' do
    status, headers, body = call env.merge("PATH_INFO" => '/api/detonate')
    [status, headers, body.map(&:upcase)]
  end

  get '/test2' do
    redirect to('/api/detonate'), 303
  end

  get '/api/detonate' do
    "boom"
  end

  post '/api/bomb' do
    body = JSON.parse request.body.read
    bomb = Bomb.create(
        activation_code:    body['activation_code'],
        deactivation_code: body['deactivation_code'],
        detonation_time: Time.parse(body['detonation_time']),
        wires: create_wires(body['wires'] || 4  )
        # session_id: session[:id]
    )
    status 201
    response_message = {status: 'ok'}
    format_response(response_message, request.accept)
  end

  put '/api/bomb/:id' do
    body = JSON.parse request.body.read
    bomb ||= Bomb.get(params[:id]) || halt(404)
    halt 500 unless bomb.update(
        activation_code:    body['activation_code'],
        deactivation_code: body['deactivation_code'],
        detonation_time: body['detonation_time'],
        session_id: session[:id]
    )
    format_response(bomb, request.accept)
  end

  delete '/api/bomb/:id' do
    bomb ||= Bomb.get(params[:id]) || halt(404)
    halt 500 unless bomb.destroy
  end
end
