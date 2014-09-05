require 'spec_helper'
require 'dinodex_controller'

describe DinodexController, "#interaction" do
	before(:each) do
		@output = double('output').as_null_object
		@dinodex = DinodexController.new(@output)
		@directory = '.\inputs'
	end

	it "sends a welcome message" do
		expect(@output).to receive(:puts).with('Welcome to Dinodex')
		@dinodex.stub(:gets).and_return('q')
		@dinodex.interactionLoop
	end

	it "prompts for input" do
		expect(@output).to receive(:puts).with('Enter your selection: (h for help)')
		@dinodex.stub(:gets).and_return('q')
		@dinodex.interactionLoop
	end
	
	it "says goodbye when we quit" do
		expect(@output).to receive(:puts).with('Goodbye')
		@dinodex.stub(:gets).and_return('q')
		@dinodex.interactionLoop
	end
end

describe DinodexController, "#load files" do
	before(:each) do
		@output = double('output').as_null_object
		@dinodex = DinodexController.new(@output)
		@directory = '.\inputs'
	end

	it "find files in our directory" do		
		expect(@output).to receive(:puts).with('Finding CSV files in ' + @directory)
		@dinodex.findCSVfiles(@directory)
	end

	it "find african_dinosaur_export" do
		expect(@output).to receive(:puts).with('Found african_dinosaur_export.csv')
		@dinodex.findCSVfiles(@directory)
	end

	it "find african_dinosaur_export" do
		expect(@output).to receive(:puts).with('Found dinodex.csv')
		@dinodex.findCSVfiles(@directory)
	end
	
	it "shows a message that loads the dinodex CSV file with 9 dinosaurs" do
		expect(@output).to receive(:puts).with('Found 9 dinosaurs in ' + @directory + '\dinodex.csv')
		@dinodex.loadCSVfile(@directory + '\dinodex.csv')
	end

	it "shows an error message when file not found" do
		expect(@output).to receive(:puts).with('File ' + @directory + '\asdf.csv not found')
		@dinodex.loadCSVfile(@directory + '\asdf.csv')
	end

	it "displays all the dinosaurs it has loaded" do
		expect(@output).to receive(:puts).with('File ' + @directory + '\asdf.csv not found')
		@dinodex.loadCSVfile(@directory + '\asdf.csv')
	end
	
end

describe DinodexController, "#display and filter" do
	before(:each) do
		@output = double('output').as_null_object
		@dinodex = DinodexController.new(@output)
		@directory = '.\inputs'
		@dinodex.start(@directory)
	end
	
	it "lists all dinosaurs" do
		expect(@output).to receive(:puts).with('Giraffatitan')
		expect(@output).to receive(:puts).with('Megalosaurus')
		@dinodex.listDisplay
	end
	
	it "lists details a single dinosaurs" do
		expect(@output).to receive(:puts).with(/Giraffat/)
		expect(@output).to receive(:puts).with(/Period/)
		expect(@output).to receive(:puts).with('Diet: Omnivore')
		expect(@output).not_to receive(:puts).with(/Continent/)
		@dinodex.detailDisplayByName('Giraffatitan')
	end

	it "does not find invalid name" do
		name = 'your mom'
		expect(@output).to receive(:puts).with('Dinosaur with name \'' + name + '\' not found.')
		@dinodex.detailDisplayByName(name)
	end
	
	it "tells me when filtering if I've entered an incorrect attribute" do
		key = 'walkinasdf'
		value = 'biped'
		expect(@output).to receive(:puts).with('Invalid dinosaur attribute \'' + key + '\' used')
		@dinodex.filterAndDisplay(key + '=' + value)
	end

	it "tells me when filtering if I've entered a blank value" do
		key = 'walking'
		expect(@output).to receive(:puts).with('Empty value for \'' + key + '\' used')
		@dinodex.filterAndDisplay(key + '=')
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
		
		@dinodex.filterAndDisplay(key + '=' + value)
	end
	
	it "filters and displays all the dinosaurs that were carnivores." do
		key = 'diet'
		value = 'carnivore'

		expect(@output).to receive(:puts).with('Afrovenator')
		expect(@output).to receive(:puts).with('Carcharodontosaurus')
		expect(@output).to receive(:puts).with('Diplocaulus')

		expect(@output).not_to receive(:puts).with('Abrictosaurus')
		expect(@output).not_to receive(:puts).with('Baryonyx')
		
		@dinodex.filterAndDisplay(key + '=' + value)
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

		@dinodex.filterAndDetail(key + '=' + value)
	end

	it "chains filters together for quadruped and carnivore" do

		expect(@output).to receive(:puts).with('Diplocaulus')
		expect(@output).to receive(:puts).with('Quetzalcoatlus')

		expect(@output).not_to receive(:puts).with('Abrictosaurus')
		expect(@output).not_to receive(:puts).with('Baryonyx')
		
		@dinodex.filterAndDisplay('walking=quadruped|diet=carnivore')
	end
	
	it "shows all the possible dinosaur attributes to filter on" do
		expect(@output).to receive(:puts).with('Keys available: name, period, diet, weight, walking, description, continent')
		@dinodex.keyDisplay
	end

  it "Grab dinosaurs for specific cretacous and late cretaceous with filter 'cretaceous'" do

    expect(@output).to receive(:puts).with('Baryonyx')
    expect(@output).to receive(:puts).with('Giganotosaurus')
    expect(@output).to receive(:puts).with('Suchomimus')

    expect(@output).not_to receive(:puts).with('Abrictosaurus')

    @dinodex.filterAndDisplay('period=cretaceous')
  end

  it "Grab only big (> 2 tons) dinosaurs." do

    expect(@output).to receive(:puts).with('Baryonyx')
    expect(@output).to receive(:puts).with('Giganotosaurus')
    expect(@output).to receive(:puts).with('Suchomimus')

    expect(@output).not_to receive(:puts).with('Abrictosaurus')

    @dinodex.filterAndDisplay('weight>2000')
  end

  it "Grab only small (< 2 tons) or dinosaurs." do

    expect(@output).not_to receive(:puts).with('Baryonyx')
    expect(@output).not_to receive(:puts).with('Giganotosaurus')
    expect(@output).not_to receive(:puts).with('Suchomimus')

    expect(@output).to receive(:puts).with('Abrictosaurus')

    @dinodex.filterAndDisplay('weight<2000')
  end

  it "filters and prints output in JSON" do
    expect(@output).to receive(:puts).with('[{"@name":"Abrictosaurus","@period":"Jurassic","@diet":"Omnivore","@weight":"100","@walking":"Biped"}]')
    @dinodex.filterAndJSON('name=Abrictosaurus')
  end

end