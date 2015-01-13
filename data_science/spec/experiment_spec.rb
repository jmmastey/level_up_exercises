require_relative '../experiment.rb'

# Only changes to this file should break the file
describe Experiment do
  let(:experiment)        { Experiment.new(results(30, 5, 30, 30)) }
  let(:tie_experiment)    { Experiment.new(results(5, 5, 5, 5)) }
  let(:sample_experiment) { Experiment.new(Parser.parse('source_data.json')) }

  def result(cohort, result)
    { "date" => "2014-03-20", "cohort" => cohort, "result" => result }
  end

  def results(a_conversions, a_rejections, b_conversions, b_rejections)
    [].tap do |result_set|
      a_conversions.times { result_set << result("A", 1) }
      a_rejections.times { result_set << result("A", 0) }
      b_conversions.times { result_set << result("B", 1) }
      b_rejections.times { result_set << result("B", 0) }
    end
  end

  describe '#format_for_abanlyzer' do
    let(:groups) { experiment.send(:format_for_abanalyzer) }
    it 'adds the cohorts' do
      expect(groups.keys).to match_array([:A, :B])
    end

    it 'adds successes and failures to groups' do
      expect(groups[:A].keys).to match_array([:failure, :success])
    end

    it 'groups by cohort name and counts successes and failures' do
      correct_output = { A: { success: 30, failure: 5 }, B: { success: 30, failure: 30 } }
      expect(groups).to eq(correct_output)
    end
  end

  describe '#report' do
    # test individual components
    # just test whether cohort.to_s
    it "returns the correct winner" do
      expect(experiment.report).to eq("Conversion %: 0.8571428571428571 within 95% confidence interval of [0.7412139741992386, 0.9730717400864756]")
      expect(tie_experiment.report).to eq("Conversion %: 0.5 within 95% confidence interval of [0.19010248589619616, 0.8098975141038038]")
      expect(sample_experiment.report).to eq("Conversion %: 0.05119896305897602 within 95% confidence interval of [0.04020173369400816, 0.06219619242394388]")
    end
  end

  describe '#difference?' do
    it "returns whether there is a statistical difference" do
      expect(experiment.difference?).to eq(true)
      expect(tie_experiment.difference?).to eq(false)
    end
  end
end
