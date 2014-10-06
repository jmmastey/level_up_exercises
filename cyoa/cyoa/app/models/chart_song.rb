class ChartSong < ActiveRecord::Base
  belongs_to :chart
  belongs_to :song
end
