require 'spec_helper'
require 'dinodex'


describe Dinodex, "#start" do
	before(:each) do
		@output = double('output').as_null_object
		@dinodex = Dinodex.new(@output)
	end
	
	it "sends a welcome message" do
		expect(@output).to receive(:puts).with('Welcome to Dinodex')
		@dinodex.start
	end
		
	it "prompts for input" do
		expect(@output).to receive(:puts).with('Enter your selection:')
		@dinodex.start
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
	
	it "loads the dinodex CSV file with 9 dinosaurs" do
		expect(@output).to receive(:puts).with('Found 9 dinosaurs in ' + @directory + '\dinodex.csv')
		@dinodex.loadCSVfile(@directory + '\dinodex.csv')
	end

	it "shows an error message when file not found" do
		expect(@output).to receive(:puts).with('File ' + @directory + '\asdf.csv not found')
		@dinodex.loadCSVfile(@directory + '\asdf.csv')
	end

end