module EventHelper
  def event_params
    params.require(:event).permit(:title, :time, :date, :description, :url, :source)
  end

  def events_params
    params.permit(:source)
  end

  def render_404
    render file: "#{Rails.root}/public/404",
           status: 404
  end
end
