module AnimeHelper
  FILLED_IN = '<span class="glyphicon glyphicon-heart rated"></span>'
  NOT_FILLED_IN = '<span class="glyphicon glyphicon-heart unrated"></span>'

  def output_stars(rating)
    html = []
    rating.times { html << FILLED_IN }
    (5 - rating).times { html << NOT_FILLED_IN }
    html.join.html_safe
  end
end
