require_relative "dinosaur_catalog"

class DinosaurView
  def self.show(context)
    context[:dinos].each do |dino|
      DinosaurCatalog::KEYS.each do |key|
        puts "#{key.capitalize}: #{dino[key]}" if dino[key]
      end
      puts '-' * 80
    end
  end
end
