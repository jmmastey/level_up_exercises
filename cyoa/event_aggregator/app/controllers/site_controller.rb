class SiteController < ApplicationController
  skip_before_action :authenticate_user!

  def about_us
    # Just render the view
  end

  def contact_us
    # Just render the view
  end

  def home
    @highlight_events = highlight_events
    # Just render the view
  end

  private

  class DummyEvent
    attr_accessor :title, :description, :categories, :image
    def initialize(title, desc, image = nil, *categories)
      @title = title
      @description = desc
      @image = image
      @categories = categories
    end
  end

  def highlight_events
    [
      DummyEvent.new("Eating event", "Yum yum good", nil, "Eating", "Making Merry"), 
      DummyEvent.new("Drinking event", "Ahh I'm drunk", nil, "Drinking"),
      DummyEvent.new("Hockey game", "He shoots he scores", nil, "Sports", "Hockey"),
      DummyEvent.new("Duck duck goose!", "Children's games are fun", nil, "Children", "Family")
    ]
  end
end
