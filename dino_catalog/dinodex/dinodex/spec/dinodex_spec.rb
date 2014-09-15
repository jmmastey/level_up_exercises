require "spec_helper"
require "dinodex_controller"

describe DinodexController, "#interaction" do
  before(:each) do
    @output = double("output").as_null_object
    @dinodex = DinodexController.new(@output)
    @directory = "./inputs"
    @dinodex.start(@directory)
  end

  it "sends a welcome message" do
    expect(@output).to receive(:puts).with("Welcome to Dinodex")
    @dinodex.stub(:gets).and_return("q")
    @dinodex.interaction
  end

  it "prompts for input" do
    expect(@output).to receive(:puts).with("Enter your selection: (h for help)")
    @dinodex.stub(:gets).and_return("q")
    @dinodex.interaction
  end

  it "says goodbye when we quit" do
    expect(@output).to receive(:puts).with("Goodbye")
    @dinodex.stub(:gets).and_return("q")
    @dinodex.interaction
  end
end

describe DinodexController, "#display and filter" do
  before(:each) do
    @output = double("output").as_null_object
    @dinodex = DinodexController.new(@output)
    @directory = "./inputs"
    @dinodex.start(@directory)
  end

  it "lists all dinosaurs" do
    expect(@output).to receive(:puts).with("Giraffatitan")
    expect(@output).to receive(:puts).with("Megalosaurus")
    @dinodex.list_display
  end

  it "lists details a single dinosaurs" do
    expect(@output).to receive(:puts).with(/Giraffat/)
    expect(@output).to receive(:puts).with(/Period/)
    expect(@output).to receive(:puts).with("Diet: Herbivore")
    expect(@output).not_to receive(:puts).with(/Continent/)
    @dinodex.detail_display_by_name("Giraffatitan")
  end

  it "does not find invalid name" do
    name = "your mom"
    valid_response = "Dinosaur with name '#{name}' not found."
    expect(@output).to receive(:puts).with(valid_response)
    @dinodex.detail_display_by_name(name)
  end

  it "tells me when filtering if I've entered an incorrect attribute" do
    key = "walkinasdf"
    value = "biped"
    valid_output = "Invalid dinosaur attribute '#{key}' used"
    expect(@output).to receive(:puts).with(valid_output)
    @dinodex.filter_and_display(key + '=' + value)
  end

  it "tells me when filtering if I've entered a blank value" do
    key = 'walking'
    expect(@output).to receive(:puts).with("Empty value for '#{key}' used")
    @dinodex.filter_and_display(key + '=')
  end

  it "filters and displays all the dinosaurs that were bipeds." do
    key = 'walking'
    value = 'biped'
    expect(@output).to receive(:puts).with('Abrictosaurus')
    expect(@output).to receive(:puts).with('Afrovenator')
    expect(@output).to receive(:puts).with('Carcharodontosaurus')
    expect(@output).to receive(:puts).with('Suchomimus')
    expect(@output).to receive(:puts).with('Albertosaurus')
    expect(@output).to receive(:puts).with('Albertonykus')
    expect(@output).to receive(:puts).with('Baryonyx')
    expect(@output).to receive(:puts).with('Deinonychus')

    expect(@output).not_to receive(:puts).with('Giraffatitan')
    expect(@output).not_to receive(:puts).with('Paralititan')
    expect(@output).not_to receive(:puts).with('Quetzalcoatlus')

    @dinodex.filter_and_display(key + '=' + value)
  end

  it "filters and displays all the dinosaurs that were carnivores." do
    key = 'diet'
    value = 'carnivore'

    expect(@output).to receive(:puts).with('Afrovenator')
    expect(@output).to receive(:puts).with('Carcharodontosaurus')
    expect(@output).to receive(:puts).with('Diplocaulus')

    expect(@output).not_to receive(:puts).with('Abrictosaurus')
    expect(@output).not_to receive(:puts).with('Baryonyx')

    @dinodex.filter_and_display(key + '=' + value)
  end

  it "filters and displays details of Afrovenator using name filter" do
    key = 'name'
    value = 'Afrovenator'

    expect(@output).to receive(:puts).with('Afrovenator')

    expect(@output).to receive(:puts).with("Period: Jurassic")
    expect(@output).to receive(:puts).with("Diet: Carnivore")
    expect(@output).not_to receive(:puts).with(/Continent/)

    expect(@output).not_to receive(:puts).with('Abrictosaurus')
    expect(@output).not_to receive(:puts).with('Baryonyx')

    @dinodex.filter_and_detail(key + '=' + value)
  end

  it "chains filters together for quadruped and carnivore" do

    expect(@output).to receive(:puts).with('Diplocaulus')
    expect(@output).to receive(:puts).with('Quetzalcoatlus')

    expect(@output).not_to receive(:puts).with('Abrictosaurus')
    expect(@output).not_to receive(:puts).with('Baryonyx')

    @dinodex.filter_and_display('walking=quadruped|diet=carnivore')
  end

  it "shows all the possible dinosaur attributes to filter on" do
    valid = 'Keys available: name, period, diet, weight, '\
      'walking, description, continent'
    expect(@output).to receive(:puts).with(valid)
    @dinodex.key_display
  end

  it "Grab dinosaurs cretacous and late cretaceous with filter 'cretaceous'" do

    expect(@output).to receive(:puts).with('Baryonyx')
    expect(@output).to receive(:puts).with('Giganotosaurus')
    expect(@output).to receive(:puts).with('Suchomimus')

    expect(@output).not_to receive(:puts).with('Abrictosaurus')

    @dinodex.filter_and_display('period=cretaceous')
  end

  it "Grab only big (> 2 tons) dinosaurs." do
    expect(@output).to receive(:puts).with('Baryonyx')
    expect(@output).to receive(:puts).with('Giganotosaurus')
    expect(@output).to receive(:puts).with('Suchomimus')

    expect(@output).not_to receive(:puts).with('Abrictosaurus')

    @dinodex.filter_and_display('weight>2000')
  end

  it "Grab only small (< 2 tons) or dinosaurs." do
    expect(@output).not_to receive(:puts).with('Baryonyx')
    expect(@output).not_to receive(:puts).with('Giganotosaurus')
    expect(@output).not_to receive(:puts).with('Suchomimus')

    expect(@output).to receive(:puts).with('Abrictosaurus')

    @dinodex.filter_and_display('weight<2000')
  end

  it "filters and prints output in JSON" do

    valid_json = '[{"@name":"Abrictosaurus","@period":"Jurassic",'
    valid_json += '"@diet":"Herbivore","@weight":"100","@walking":"Biped"}]'
    expect(@output).to receive(:puts).with(valid_json)
    @dinodex.filter_and_json('name=Abrictosaurus')
  end

end
