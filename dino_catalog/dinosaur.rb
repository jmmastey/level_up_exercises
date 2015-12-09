class Dinosaur
  def self.normalize_african(entry)
   {
      :name => entry[:genus],
      :period => entry[:period],
      :continent => nil,
      :diet => nil,
      :carnivore => (entry[:diet] == "Yes"),
      :weight => entry[:weight],
      :walking => entry[:walking],
      :description => nil,
    }
  end

  def self.normalize_dinodex(entry)
   {
      :name => entry[:name],
      :period => entry[:period],
      :continent => entry[:continent],
      :diet => entry[:diet],
      :carnivore => self.carnivore_for_dinodex(entry[:diet]),
      :weight => entry[:weight_in_lbs],
      :walking => entry[:walking],
      :description => entry[:description],
    }
  end

  def self.carnivore_for_dinodex(diet)
    %w(Carnivore Pescivore Insectivore).include? diet
  end

end