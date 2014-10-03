module EveCentral
  module ParamMapping
    private

    def create_post_param
      return "#{key}=#{value}" unless value.is_a?(Enumerable)

      value.map { |element| create_post_param(key, element) }
           .join("&")
    end

    def create_post_params(data)
      data.map { |key, value| create_post_param(key, value) }
          .join("&")
    end
  end
end
