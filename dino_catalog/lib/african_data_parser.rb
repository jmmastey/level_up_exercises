# Normalizes dinosaur data from the african_dinosaur_export.csv file
require_relative 'dino_data_parser'
class AfricanDataParser < DinoDataParser
  def data_file
    'lib/data/african_dinosaur_export.csv'
  end

  def format_data(dino)
    {
      :name                 => dino[:genus],
      :period               => correct_period(dino[:period])[0],
      :'period subdivision' => correct_period(dino[:period])[1],
      :continent            => 'Africa',
      :diet                 => carnivore_or_not(dino[:carnivore]),
      :weight               => dino[:weight],
      :walking              => dino[:walking],
    }
  end

  def correct_period(period)
    if period.casecmp('albian') == 0
      %w(Early\ Cretaceous Albian)
    else
      [period, nil]
    end
  end

  def carnivore_or_not(diet)
    diet.casecmp('yes') == 0 ? 'Carnivore' : nil
  end
end
