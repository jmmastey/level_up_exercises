# File bomb.rb
class Overlord < Sinatra::Application

  get '/api/bomb' do
    format_response(Bomb.all, request.accept)
  end

  get '/api/bomb/:id' do
    bomb ||= Bomb.get(params[:id]) || halt(404)
    format_response(bomb, request.accept)
  end

  post '/api/bomb' do
    body = JSON.parse request.body.read
    bomb = Bomb.create(
        activation:    body['activation'],
        deactivation: body['deactivation'],
        detonation: body['detonation'],
        session_id: session[:id]
    )
    status 201
    format_response(bomb, request.accept)
  end

  put '/api/bomb/:id' do
    body = JSON.parse request.body.read
    bomb ||= Bomb.get(params[:id]) || halt(404)
    halt 500 unless bomb.update(
        activation:    body['activation'],
        deactivation: body['deactivation'],
        detonation: body['detonation'],
        session_id: session[:id]
    )
    format_response(bomb, request.accept)
  end

  delete '/api/bomb/:id' do
    bomb ||= Bomb.get(params[:id]) || halt(404)
    halt 500 unless bomb.destroy
  end
end
