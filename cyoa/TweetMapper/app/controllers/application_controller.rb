class ApplicationController < ActionController::Base
  private

  def json_response(errors = [], payload = {})
    status = errors.length > 0 ? 'error' : 'ok'
    render json: { status: status, messages: errors, data: payload }
  end
end
