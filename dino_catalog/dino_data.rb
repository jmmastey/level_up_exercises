# Dino Data Obj used by dino_cvs_data_mapper.rb

class DinoData
  attr_accessor :name, :period, :continent, :diet, :weight, :walking, :desc

  def initialize
    @label =
      {
        name: "Name", period: "Period", continent: "Continent",
        diet: "Diet", weight: "Weight", walking: "Walk", desc: "Description"
      }
  end

  # Print label
  def labels
    out_str = ''
    @label.each do |attr, label|
      out_str << sprintf("%20s", label) if send(attr)
    end

    out_str
  end

  # Print this record
  def to_s
    out_str = ''
    @label.each do |attr, label|
      if (val = send(attr))
        out_str << sprintf("%10s", val)
      end
    end

    out_str
  end
end
