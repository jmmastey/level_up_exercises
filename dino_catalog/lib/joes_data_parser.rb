# Normalizes dinosaur data from Joe's Dinodex.csv file
require_relative 'dino_data_parser'
class JoesDataParser < DinoDataParser
  def data_file
    'lib/data/dinodex.csv'
  end

  def format_data(dino)
    {
      :name                 => dino[:name],
      :period               => correct_period(dino[:period])[0],
      :'period subdivision' => correct_period(dino[:period])[1],
      :continent            => dino[:continent],
      :diet                 => correct_diet(dino[:diet])[0],
      :'diet subtype'       => correct_diet(dino[:diet])[1],
      :weight               => dino[:weight_in_lbs],
      :walking              => dino[:walking],
      :description          => dino[:description],
    }
  end

  def correct_period(period)
    if period.casecmp('oxfordian') == 0
      %w(Late\ Jurassic Oxfordian)
    else
      [period, nil]
    end
  end

  def correct_diet(diet)
    case diet
      when /insectivore/i then %w(Carnivore Insectivore)
      when /piscivore/i   then %w(Carnivore Piscivore)
      else [diet, nil]
    end
  end
end
