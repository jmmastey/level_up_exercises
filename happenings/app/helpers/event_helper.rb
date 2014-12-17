module EventHelper
  def event_change_permitted_params(raw_params)
    raw_params.require(:event).permit(:title, :starts_at, :description, :url, :category)
  end
end
