require_relative '../experiment.rb'

# Only changes to this file should break the file
describe Experiment do
  let(:experiment) { Experiment.new(results(30, 5, 30, 30)) }
  let(:tie_experiment) { Experiment.new(results(5, 5, 5, 5)) }
  let(:sample_experiment) { Experiment.new(Parser.parse('source_data.json')) }

  def result(cohort, result)
    { "date" => "2014-03-20", "cohort" => cohort, "result" => result }
  end

  def results(a_conversions, a_rejections, b_conversions, b_rejections)
    array = []
    Array.new(a_rejections).each { array << result("A", 0) }
    Array.new(a_conversions).each { array << result("A", 1) }
    Array.new(b_rejections).each { array << result("B", 0) }
    Array.new(b_conversions).each { array << result("B", 1) }
    array
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
      expect(groups).to eq({ :A => { :success => 30, :failure => 5 }, :B => { :success => 30, :failure => 30 } })
    end
  end

  describe '#report' do
    it "returns the correct winner" do
      expect(experiment.report).to eq("Winner: Cohort A")
      expect(tie_experiment.report).to eq("No clear winner")
      expect(sample_experiment.report).to eq("Winner: Cohort A")
    end
  end

  describe '#chiquare_p' do
    it "returns the correct chisquare_p value" do
      expect(experiment.chiquare_p.round(4)).to eq(0.0005)
    end
  end
end
