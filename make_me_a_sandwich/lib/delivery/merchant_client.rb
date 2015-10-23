module Delivery
  class MerchantClient
    RESTAURANT_MERCHANT_TYPE = "R"
    VALID_ORDER_METHODS = [:delivery, :pickup]

    def search(order_method, search_params = {})
      unless valid_order_method?(order_method)
        raise ArgumentError, "Invalid order method."
      end

      search_params[:merchant_type] = RESTAURANT_MERCHANT_TYPE
    end

    private

    def valid_order_method?(method)
      VALID_ORDER_METHODS.include?(method)
    end
  end
end
