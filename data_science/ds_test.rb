describe DataScience do
  
  let(:source_file) {"./source_data.json"}
  let(:missing_file) {"./missing_file.json"}

  let (:datascience) {DataScience.new(filepaths: [source_file])}

  # class or method
  # describe "#initialize" do
  #   # context for a condition, with valid data, 
  #   context "with a valid source_data file" do
  #     it "loads all the experiments"
  #       expect(datascience.size).to eq(2891)
  #     end
  #   end
  # end
  
end
