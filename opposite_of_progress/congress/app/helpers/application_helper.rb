# Application helper module
module ApplicationHelper
  def self.date_display date
    date.strftime("%B %d %Y")
  end
end
