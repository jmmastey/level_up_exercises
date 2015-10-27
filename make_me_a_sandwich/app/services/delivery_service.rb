require "delivery"

class DeliveryService
  cattr_reader :delivery_client, instance_accessor: false do
    Delivery::Client.new(AppConfig.delivery.site,
                         ENV["DELIVERY_API_KEY"],
                         ENV["DELIVERY_API_SECRET"],
                         delivery_auth_callback_url)
  end

  def self.access_token(code)
    delivery_client.access_token(code)
  end

  def self.customer_info(access_token)
    delivery_client.customer_info(access_token)
  end
end
