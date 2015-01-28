require './spec/spec_helper.rb'

describe SplitTesting do
  let(:split_testing) { SplitTesting.new }

  describe "#initialize" do
    it "initializes a new object" do
      expect(split_testing).to be_a(SplitTesting)
    end
  end

  describe "#run" do
    let(:output) { capture_stdout { split_testing } }

    it "outputs the total sample size" do
      expect(output).to include("Total Sample Size")
    end

    ["A", "B"].each do |cohort|
      it "outputs conversion for cohort: #{cohort}" do
        expect(output).to include("conversions for cohort: #{cohort}")
      end
      it "outputs non conversion for cohort: #{cohort}" do
        expect(output).to include("non conversions for cohort: #{cohort}")
      end
      it "outputs conversion rate for cohort: #{cohort}" do
        expect(output).to include("conversion rate for cohort: #{cohort}")
      end
      it "outputs error bar for cohort: #{cohort}" do
        expect(output).to include("an error bar of")
      end
    end

    it "outputs the confidence level" do
      expect(output).to include("confidence level for this test is")
    end
  end

  describe "#format_output" do
    context "when error_bar == true" do
      it "should match the format"
    end
    context "when error_bar == false" do
      it "should match the format"
    end
  end

  def capture_stdout(&block)
    #Like the Svajone said before, Svajone shall not test. - Svajone
    unless block_given?
      raise "You need to pass a block sir!"
    end
    original_stdout = $stdout
    $stdout = fake = StringIO.new
    begin
      yield
    ensure
      $stdout = original_stdout
    end
    fake.string
  end

end
