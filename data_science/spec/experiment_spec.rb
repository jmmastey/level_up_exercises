require_relative '../experiment.rb'

describe Experiment do
  let(:experiment) { Experiment.new(results(30, 5, 30, 30)) }
  let(:tie_experiment) { Experiment.new(results(5, 5, 5, 5)) }

  def result(cohort, result)
    { "date" => "2014-03-20", "cohort" => cohort, "result" => result }
  end

  def results(a_conversions, a_rejections, b_conversions, b_rejections)
    [].tap do |result_set|
      a_conversions.times { result_set << result("A", 1) }
      a_rejections.times  { result_set << result("A", 0) }
      b_conversions.times { result_set << result("B", 1) }
      b_rejections.times  { result_set << result("B", 0) }
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
      correct_output = {
        A: { success: 30, failure: 5 },
        B: { success: 30, failure: 30 },
      }
      expect(groups).to eq(correct_output)
    end
  end

  describe '#winner' do
    it "returns the correct winner" do
      expect(experiment.report).to eq("A")
      expect(tie_experiment.report).to eq("There is no clear winner!")
    end
  end

  describe '#difference?' do
    it "returns if true there is a statistical difference" do
      expect(experiment.difference?).to eq(true) # 0.0004 <= 0.05
    end
    it "returns false if there is no statistical difference" do
      expect(tie_experiment.difference?).to eq(false) # 1 <= 0.05
    end
  end
end
