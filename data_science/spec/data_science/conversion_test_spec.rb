require 'data_science/conversion_test'
require 'data_science/json_parser'

module DataScience
  SAMPLE_PRINT_OUT = <<-HEREDOC
    \nBelow are the results of the web conversion data:\n\n
    Total Size of the Control Group: 4
    Number of Conversions for the Control Group: 1\n\n
    Total Size of the Test Group: 1
    Number of Conversions for the Test Group: 1\n\n
    Conversion rate for the Control Group: 50 +- 2%
    Conversion rate for the Test Group: 40 +- 2%\n\n
    Confidence Level: 95%
  HEREDOC

  describe ConversionTest do
    before do
      @conversion_test = ConversionTest.new('sample_test')
    end

    it 'has a name' do
      expect(@conversion_test.name).to eq("sample_test")
    end

    it 'creates a sample of data points' do
      expect(@conversion_test.sample).to be_an_instance_of(Sample)
    end

    it 'creates a sample of data points from a json file' do
      json_data = JsonParser.parse_file(File.join(File.dirname(__FILE__), "source_data_test.json"))
      @conversion_test.import_data(json_data)
      expect(@conversion_test.sample.data_points.size).to eq(4)
    end

    context "after running the statistical tests" do
      before do
        @conversion_test.stub(:print_statistical_results).with("A", "B").and_return(SAMPLE_PRINT_OUT)
      end

      it 'will print out the results' do
        expect(@conversion_test.print_statistical_results("A", "B")).to match(/Below are the results of the web conversion data:/)
        expect(@conversion_test.print_statistical_results("A", "B")).to match(/Total Size of the Control Group: 4/)
        expect(@conversion_test.print_statistical_results("A", "B")).to match(/Number of Conversions for the Control Group: 1/)
        expect(@conversion_test.print_statistical_results("A", "B")).to match(/Total Size of the Test Group: 1/)
        expect(@conversion_test.print_statistical_results("A", "B")).to match(/Number of Conversions for the Test Group: 1/)
        expect(@conversion_test.print_statistical_results("A", "B")).to match(/Conversion rate for the Control Group: 50 \+- 2%/)
        expect(@conversion_test.print_statistical_results("A", "B")).to match(/Conversion rate for the Test Group: 40 \+- 2%/)
        expect(@conversion_test.print_statistical_results("A", "B")).to match(/Confidence Level: 95%/)
      end
    end
  end
end
