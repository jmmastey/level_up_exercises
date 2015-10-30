require "interactor"

class DeliveryLoginUser
  include Interactor

  def call
    fetch_access_token
    info = fetch_customer_info unless context.fail?
    find_or_create_user(info) unless context.fail?
  end

  private

  def bad_response(request_id, response)
    context.failed_request_id = request_id
    context.errors = response.result.try(:[], "message")
    context.fail!
  end

  def fetch_access_token
    response = context.client.access_token(context.auth_code)
    return bad_response(:access_token, response) unless response.status == :ok

    [:access_token, :expires, :refresh_token].each do |key|
      context[key] = response.result[key.to_s]
    end
  end

  def fetch_customer_info
    response = context.client.customer_info(context.access_token)
    return bad_response(:customer_info, response) unless response.status == :ok

    user_data = response.result["user"]

    user_data.each_with_object({}) do |(key, value), result|
      result[key.to_sym] = value
    end
  end

  def find_or_create_user(info)
    context.user = User.find_or_create_by(external_id: info[:human_id]) do |u|
      u.email = info[:email]
      u.first_name = info[:first_name]
      u.last_name = info[:last_name]
    end
  end
end
