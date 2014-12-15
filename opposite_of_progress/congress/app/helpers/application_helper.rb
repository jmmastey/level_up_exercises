# Application helper module
module ApplicationHelper
  def self.date_display date
    date.strftime("%B %d %Y") if date
  end
end
