require 'spec_helper'
require 'dinodex'

describe Dinodex, "#interaction" do
	before(:each) do
		@output = double('output').as_null_object
		@dinodex = Dinodex.new(@output)
		@directory = '.\inputs'
	end

	it "sends a welcome message" do
		expect(@output).to receive(:puts).with('Welcome to Dinodex')
		@dinodex.stub(:gets).and_return('q')
		@dinodex.interactionLoop
	end

	it "prompts for input" do
		expect(@output).to receive(:puts).with('Enter your selection:')
		@dinodex.stub(:gets).and_return('q')
		@dinodex.interactionLoop
	end
	
	it "says goodbye when we quit" do
		expect(@output).to receive(:puts).with('Goodbye')
		@dinodex.stub(:gets).and_return('q')
		@dinodex.interactionLoop
	end
end

describe Dinodex, "#load files" do
	before(:each) do
		@output = double('output').as_null_object
		@dinodex = Dinodex.new(@output)
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


describe Dinodex, "#display" do
	before(:each) do
		@output = double('output').as_null_object
		@dinodex = Dinodex.new(@output)
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
		@dinodex.detailDisplay('Giraffatitan')
	end

	it "does not find invalid name" do
		name = 'your mom'
		expect(@output).to receive(:puts).with('Dinosaur with name \'' + name + '\' not found.')
		@dinodex.detailDisplay(name)
	end
	

#4. Also, I'll probably want to print all the dinosaurs in a given collection (after filtering, etc).

#### Extra Credit

#1. I would love to have a way to do (and chain) generic search by parameters. I can pass in a hash, and I'd like to get the proper list of dinos back out.
#2. CSV isn't may favorite format in the world. Can you implement a JSON export feature?
end