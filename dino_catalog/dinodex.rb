require 'csv'

dinosaurs = CSV.read('dinodex.csv', headers:true)

dinosaurs.each do |dino|
  p dino.to_hash

end
class Dinosaur
  def init(options)
    @name = option[:Name]

  end
end
