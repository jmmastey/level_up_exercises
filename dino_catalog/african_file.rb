require_relative 'file_handler'
require_relative 'dinosaur'

class AfricanFile < FileHandler
  def map_to_object(content)
    #better way?
    if content['Carnivore'] == 'Yes'
      content['Carnivore'] = 'Carnivore'
    else
      content['Carnivore'] = 'Herbivore'
    end

    Dinosaur.new(:name => content['Genus'],
                 :period => content['Period'],
                 :diet => content['Carnivore'],
                 :weight => content['Weight'],
                 :walking => content['Walking'],
                 :continent => "Africa",)
  end
end
