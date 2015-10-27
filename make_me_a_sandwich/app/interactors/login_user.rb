require "interactor"

class LoginUser
  include Interactor

  def call
    get_access_token
    get_customer_info unless context.fail?
  end

  private

  def bad_response(request_id, response)
    context.failed_request_id = request_id
    context.errors = response.result.try(:[], "message")
    context.fail!
  end

  def get_access_token
    response = DeliveryService.access_token(context.auth_code)
    return bad_response(:access_token, response) unless response.status == :ok

    [:access_token, :expires, :refresh_token].each do |key|
      context[key] = response.result[key.to_s]
    end
  end

  def get_customer_info
    response = DeliveryService.customer_info(context.access_token)
    return bad_response(:customer_info, response) unless response.status == :ok

    [:email, :first_name, :last_name].each do |key|
      context[key] = response.result[key.to_s]
    end
  end
end
