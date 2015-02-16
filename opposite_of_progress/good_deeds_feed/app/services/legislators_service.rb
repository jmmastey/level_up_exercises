require 'csv'
class LegislatorsService

  def initialize
  end

  def create_legislators
    CSV.foreach("../../db/legislators.csv", headers: true) do |legislator|
      p legislator.to_h
    end
  end
end

a = LegislatorsService.new
a.create_legislators