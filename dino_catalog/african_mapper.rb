class AfricanMapper

  HEADER = ["Genus", "Period", "Carnivore", "Weight", "Walking"]

  PARSER = lambda {|data| Hash[
    :name => data["Genus"],
    :period => data["Period"],
    :diet => to_diet(data["Carnivore"]),
    :weight => data["Weight"],
    :walking => data["Walking"]]
  }

  def self.get_mapper
    {HEADER => PARSER}
  end

  private

  def self.to_diet(data)
    if data == "Yes"
      "Carnivore"
    else
      "Herbivore"
    end
  end

end
