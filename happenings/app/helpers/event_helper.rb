module EventHelper
  def filter_params(raw_params)
    raw_params.permit(:title, :time, :date, :description, :url, :source)
  end
end
