# File bomb.rb
class Overlord < Sinatra::Application


  get '/api/bomb/cut/:id/:wire_id' do
    bomb ||= Bomb.get(params[:id]) || halt(404)
    wire ||= bomb.wires.get(params[:wire_id]) || halt(404)

    wire_response = cut_wire_status(wire)
    cut_wire_response(bomb, wire_response, request.accept)
  end

  get '/api/bomb/list' do
    bombs = Bomb.all.map do |bomb|
      { id: bomb.id, status: bomb.status, attempts: bomb.attempts,
        detonation_time: bomb.detonation_time }
    end
    format_response(bombs, request.accept)
  end

  get '/api/bomb/:id/activate/:activation_code' do
    bomb ||= Bomb.get(params[:id]) || halt(404)
    valid_activation_code = bomb.activation_code.eql?(params[:activation_code])
    if valid_activation_code
      valid_activation(bomb)
    else
      invalid_activation(bomb)
    end
  end

  get '/api/bomb/:id/deactivate/:deactivation_code' do
    bomb ||= Bomb.get(params[:id]) || halt(404)
    valid_deactivation_code = bomb.deactivation_code.eql?(params[:deactivation_code]||0)
    if valid_deactivation_code
      valid_deactivation(bomb)
    else
      invalid_deactivation(bomb)
    end
  end

  get '/api/bomb/:id/deactivate*' do
    bomb ||= Bomb.get(params[:id]) || halt(404)
    valid_deactivation_code = bomb.deactivation_code.eql?(0)
    if valid_deactivation_code
      valid_deactivation(bomb)
    else
      invalid_deactivation(bomb)
    end
  end



  get '/api/bomb/:id' do
    bomb ||= Bomb.get(params[:id]) || halt(404)
    format_bomb(bomb)
    # format_response(bomb_response, request.accept)
  end

  post '/api/bomb' do
    # body = JSON.parse request.body.read
    begin
      errors = {}
      codes = %w(activation_code deactivation_code)
      codes.each do |code|
        errors[code] = "code is too short" if json[code.to_sym].size < 4
      end
      unless errors.empty?
        status 400
        return format_response(errors, request.accept)
      end
      bomb = Bomb.create(
          activation_code: json[:activation_code] || '1234',
          deactivation_code: json[:deactivation_code] || '0000',
          detonation_time: json[:detonation_time] || '60',
          wires: create_wires(json[:wires] || 5
         )
      )
    rescue
      halt(404)
    end
    status 201
    session['bomb_id'] = bomb.id
    session['bomb_status'] = bomb.status
    response_message = { status: 'ok', id: bomb.id }
    # format_response(response_message, request.accept)
    format_bomb(bomb)
  end

  get '/test' do
    status, headers, body = call env.merge("PATH_INFO" => '/api/detonate')
    [status, headers, body.map(&:upcase)]
  end

  get '/test2' do
    redirect to('/api/detonate'), 303
  end

  get '/api/bomb/detonate/:id' do
    bomb ||= Bomb.get(params[:id]) || halt(404)
    bomb.status = :exploded
    bomb.save
    format_bomb(bomb)
  end


  put '/api/bomb/:id' do
    bomb ||= Bomb.get(params[:id]) || halt(404)
    halt 500 unless bomb.update(
        activation_code: json['activation_code'],
        deactivation_code: json['deactivation_code'],
        detonation_time: json['detonation_time'],
        session_id: session[:id]
    )
    format_response(bomb, request.accept)
  end

  delete '/api/bomb/:id' do
    bomb ||= Bomb.get(params[:id]) || halt(404)
    halt 500 unless bomb.destroy
  end
end
