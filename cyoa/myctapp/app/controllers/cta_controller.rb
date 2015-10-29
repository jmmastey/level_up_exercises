class CtaController < ApplicationController
  def routes
    @api = CTA.new
    render_response({ routes: @api.load_routes })
  end

  def route_directions
    @api = CTA.new
    render_response({ directions: @api.load_direction(params[:route_id]) })
  end

  def route_stops
    @api = CTA.new
    render_response({ stops: @api.load_stops(params[:route_id], params[:route_direction]) })
  end

  def stop_eta
    @api = CTA.new
    render_response({ predictions: @api.load_stop_eta(params[:stop_id], params[:route_id]) })
  end

  private

  def render_response(results)
    render json: { status: :ok }.merge(results)
  end
end
