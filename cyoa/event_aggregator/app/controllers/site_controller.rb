class SiteController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    @highlight_events = highlight_events
    @meetups = meetups
    @opening_night_events = opening_night_events
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

  def meetups
    [
      DummyEvent.new("Meet This", "So much fun", nil, "Meetups", "This"),
      DummyEvent.new("Meet That", "Not much fun", nil, "Meetups", "That"),
    ]
  end

  def opening_night_events
    [
      DummyEvent.new("See This", "This's is better", nil, "Theater", "This"),
      DummyEvent.new("See That", "That's great", nil, "Theater", "That"),
    ]
  end
end
