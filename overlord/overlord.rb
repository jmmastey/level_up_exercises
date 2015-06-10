require 'json'
require 'sinatra'
require 'tilt/erb'
require 'pry'
require_relative 'bomb'
require_relative 'constants'

class Overlord < Sinatra::Base
  enable :sessions

  get '/' do
    if session[:bomb]
      options = session[:bomb] ? { bomb_status: session[:bomb].status } : {}
      erb(:index, locals: options)
    else
      erb(:no_bomb)
    end
  end

  post '/activate' do
    catch_exceptions do
      code = params['code'] || ''
      errors = session[:bomb].activate(code)
      json_response(errors)
    end
  end

  post '/deactivate' do
    catch_exceptions do
      code = params['code'] || ''
      errors = session[:bomb].deactivate(code)
      json_response(errors)
    end
  end

  post '/create' do
    catch_exceptions do
      session[:bomb] = Bomb.new(params)
      json_response
    end
  end

  private

  def catch_exceptions(&block)
    block.call if block_given?
  rescue *ERROR_TYPES => error
    message = error.message
    if DEBUG && error.backtrace.length > 0
      message << "\n#{error.backtrace.join('\n')}"
    end
    json_response([message], 'error')
  end

  def bomb_data
    {
      error_count: session[:bomb].error_count,
      status: session[:bomb].status,
    }
  end

  def json_response(errors = [], status = 'ok')
    data = status != 'ok' ? {} : { bomb: bomb_data }
    JSON.generate(
      status: status,
      errors: errors.join('\n'),
      data: data,
    )
  end
end
