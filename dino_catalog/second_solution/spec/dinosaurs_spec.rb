require_relative "../dinosaurs"

describe Dinosaurs do

  format_one_file_data = "NAME,PERIOD,CONTINENT,DIET,WEIGHT_IN_LBS,WALKING,DESCRIPTION\nAlbertosaurus,Late Cretaceous,North America,Carnivore,2000,Biped,Like a T-Rex but smaller.\nAlbertonykus,Early Cretaceous,North America,Insectivore,,Biped,Earliest known Alvarezsaurid.\nBaryonyx,Early Cretaceous,Europe,Piscivore,6000,Biped,One of the only known dinosaurs with a fish-only diet.\nDeinonychus,Early Cretaceous,North America,Carnivore,150,Biped,\nDiplocaulus,Late Permian,North America,Carnivore,,Quadruped,They actually had fins on the side of their body."

  format_two_file_data = "Genus,Period,Carnivore,Weight,Walking\nAbrictosaurus,Jurassic,No,100,Biped\nAfrovenator,Jurassic,Yes,,Biped\nCarcharodontosaurus,Albian,Yes,3000,Biped"

  let(:default_dex) { Dinosaurs.new }

  let(:form_one_dex) do
    File.stub(:open).with("file","csv") { StringIO.new(format_one_file_data) }
    Dinosaurs.new(file)
  end

  let(:csv_header_row){ CSV::Row.new ['Genus','Period','Carnivore','Weight','Walking'], ['Abrictosaurus','Jurassic','No','100','Biped'], converters: :numeric, headers: true, :header_converters => lambda {|h| h.downcase}}

  it "creates a Dinosaurs object" do
    expect(default_dex).to be_an_instance_of Dinosaurs
  end

  # it "accepts an optional file path on instantiation" do
    
  # end

end