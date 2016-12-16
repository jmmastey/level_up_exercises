  require 'csv'
  require 'fileutils'

  format_dex_file_data = "NAME,PERIOD,CONTINENT,DIET,WEIGHT_IN_LBS,WALKING,DESCRIPTION\nAlbertosaurus,Late Cretaceous,North America,Carnivore,2000,Biped,Like a T-Rex but smaller.\nAlbertonykus,Early Cretaceous,North America,Insectivore,,Biped,Earliest known Alvarezsaurid.\nBaryonyx,Early Cretaceous,Europe,Piscivore,6000,Biped,One of the only known dinosaurs with a fish-only diet.\nDeinonychus,Early Cretaceous,North America,Carnivore,150,Biped,\nDiplocaulus,Late Permian,North America,Carnivore,,Quadruped,They actually had fins on the side of their body."

  format_african_file_data = "Genus,Period,Carnivore,Weight,Walking\nAbrictosaurus,Jurassic,No,100,Biped\nAfrovenator,Jurassic,Yes,,Biped\nCarcharodontosaurus,Albian,Yes,3000,Biped"



class Test

  def initialize
    @ary = []
  end

  def chn1
    @ary << 1
    self
  end

  def chn2
    @ary << 2
    self
  end

end

t = Test.new
p t.chn1.chn1.chn2

# reset_csv(first_path, format_dex_file_data)
# reset_csv(second_path, format_african_file_data)


#CSV.open("")
# CSV.parse(format_one_file_data, converters: :numeric, 
#                   headers: true,
#                   :header_converters => lambda {|h| h.downcase}) do |row|
#   p row
# end

