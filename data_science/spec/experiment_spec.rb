require_relative '../experiment.rb'

# Only changes to this file should break the file
describe Experiment do
  let(:experiment)        { Experiment.new(results(30,5,30,30)) }
  let(:tie_experiment)    { Experiment.new(results(5,5,5,5))    }
  let(:sample_experiment) { Experiment.new(Parser.parse('source_data.json'))       }

  def result(cohort, result)
    { "date"=>"2014-03-20", "cohort"=>cohort, "result"=>result }
  end

  def results(a_conversions, a_rejections, b_conversions, b_rejections)
    array = []
    Array.new(a_rejections).each  { array << result("A", 0) }
    Array.new(a_conversions).each { array << result("A", 1) }
    Array.new(b_rejections).each  { array << result("B", 0) }
    Array.new(b_conversions).each { array << result("B", 1) }
    array
  end

  describe '#build_groups' do
    let(:groups){ experiment.send(:build_groups) }
    it 'adds the cohorts' do
      expect(groups.keys).to match_array([:A, :B])
    end

    it 'adds successes and failures to groups' do
      expect(groups[:A].keys).to match_array([:failure, :success])
    end

    it 'groups by cohort name and counts successes and failures' do
      expect(groups).to eq({:A=>{:success=>30, :failure=>5}, :B=>{:success=>30, :failure=>30}})
    end
  end

  describe '#winner' do
    it "returns the correct winner" do
      expect(experiment.winner).to        eq("Winner: Cohort A")
      expect(tie_experiment.winner).to    eq("No clear winner")
      expect(sample_experiment.winner).to eq("Winner: Cohort B")
    end
  end

  describe '#tester' do
    # use send it access private method
    let(:tester){ experiment.send(:tester) }

    it "returns the correct chisquare_p value" do
      expect(tester.chisquare_p.round(4)).to eq(0.0005)
    end

  end

  # describe '#valid_difference?' do
  #   context 'when there is a valid difference' do
  #     let(:test) { true }
  #
  #     it "returns the correct winner" do
  #       expect(test).to eq(true)
  #       # expect(experiment.valid_difference?(test).to eq(true))
  #     end
  #   end
  # end

  # describe '#report' do
  #   it "gives the correct chi-square p-value" do
  #     expect(experiment.report).to eq("Chi square 0.0316. true")
  #   end
  #
  #   it "then it creates an array of cohort objects"
  #   it "returns chisquare_p"
  # end
end
