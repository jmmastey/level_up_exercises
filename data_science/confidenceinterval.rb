
class ConfidenceInterval
  def initialize(params)
    @probability = params[:probability_of_success]
    @size = params[:observation_size]
    @confidence_level = params[:confidence_level]
  end

  def standard_deviation
    (@probability * (1 - @probability) / @size)**0.5
  end
end
