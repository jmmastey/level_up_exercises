require '../lib/ab_tester'

describe ABTester do
  let(:cohort_visits) do
    [
      { 'date' => '2014-03-20', 'cohort' => 'A', 'result' => 0 },
      { 'date' => '2014-03-20', 'cohort' => 'A', 'result' => 0 },
      { 'date' => '2014-03-20', 'cohort' => 'A', 'result' => 0 },
      { 'date' => '2014-03-20', 'cohort' => 'A', 'result' => 0 },
      { 'date' => '2014-03-19', 'cohort' => 'A', 'result' => 0 },
      { 'date' => '2014-03-19', 'cohort' => 'A', 'result' => 0 },
      { 'date' => '2014-03-18', 'cohort' => 'A', 'result' => 0 },
      { 'date' => '2014-03-18', 'cohort' => 'A', 'result' => 0 },
      { 'date' => '2014-03-18', 'cohort' => 'A', 'result' => 0 },
      { 'date' => '2014-03-17', 'cohort' => 'A', 'result' => 0 },
      { 'date' => '2014-03-16', 'cohort' => 'A', 'result' => 0 },
      { 'date' => '2014-03-16', 'cohort' => 'A', 'result' => 0 },
      { 'date' => '2014-03-16', 'cohort' => 'A', 'result' => 0 },
      { 'date' => '2014-03-15', 'cohort' => 'A', 'result' => 1 },
      { 'date' => '2014-03-15', 'cohort' => 'A', 'result' => 1 },
      { 'date' => '2014-03-15', 'cohort' => 'A', 'result' => 0 },
      { 'date' => '2014-03-15', 'cohort' => 'A', 'result' => 0 },
      { 'date' => '2014-03-14', 'cohort' => 'A', 'result' => 0 },
      { 'date' => '2014-03-14', 'cohort' => 'A', 'result' => 0 },
      { 'date' => '2014-03-13', 'cohort' => 'A', 'result' => 1 },
      { 'date' => '2014-03-13', 'cohort' => 'B', 'result' => 1 },
      { 'date' => '2014-03-18', 'cohort' => 'B', 'result' => 0 },
      { 'date' => '2014-03-17', 'cohort' => 'B', 'result' => 1 },
      { 'date' => '2014-03-19', 'cohort' => 'B', 'result' => 0 },
      { 'date' => '2014-03-18', 'cohort' => 'B', 'result' => 0 },
      { 'date' => '2014-03-18', 'cohort' => 'B', 'result' => 0 },
      { 'date' => '2014-03-16', 'cohort' => 'B', 'result' => 1 },
      { 'date' => '2014-03-16', 'cohort' => 'B', 'result' => 0 },
      { 'date' => '2014-03-15', 'cohort' => 'B', 'result' => 0 },
      { 'date' => '2014-03-14', 'cohort' => 'B', 'result' => 0 },
      { 'date' => '2014-03-13', 'cohort' => 'B', 'result' => 0 },
      { 'date' => '2014-03-20', 'cohort' => 'B', 'result' => 0 },
      { 'date' => '2014-03-20', 'cohort' => 'B', 'result' => 1 },
      { 'date' => '2014-03-19', 'cohort' => 'B', 'result' => 0 },
      { 'date' => '2014-03-18', 'cohort' => 'B', 'result' => 1 },
      { 'date' => '2014-03-18', 'cohort' => 'B', 'result' => 0 },
      { 'date' => '2014-03-18', 'cohort' => 'B', 'result' => 1 },
      { 'date' => '2014-03-19', 'cohort' => 'B', 'result' => 0 },
      { 'date' => '2014-03-19', 'cohort' => 'B', 'result' => 1 },
      { 'date' => '2014-03-20', 'cohort' => 'B', 'result' => 1 },
      { 'date' => '2014-03-20', 'cohort' => 'B', 'result' => 1 },
      { 'date' => '2014-03-20', 'cohort' => 'B', 'result' => 1 },
    ]
  end

  let(:cohort_a) do
    [
      { 'date' => '2014-03-20', 'cohort' => 'A', 'result' => 0 },
      { 'date' => '2014-03-20', 'cohort' => 'A', 'result' => 0 },
      { 'date' => '2014-03-20', 'cohort' => 'A', 'result' => 0 },
      { 'date' => '2014-03-20', 'cohort' => 'A', 'result' => 0 },
      { 'date' => '2014-03-19', 'cohort' => 'A', 'result' => 0 },
      { 'date' => '2014-03-19', 'cohort' => 'A', 'result' => 0 },
      { 'date' => '2014-03-18', 'cohort' => 'A', 'result' => 0 },
      { 'date' => '2014-03-18', 'cohort' => 'A', 'result' => 0 },
      { 'date' => '2014-03-18', 'cohort' => 'A', 'result' => 0 },
      { 'date' => '2014-03-17', 'cohort' => 'A', 'result' => 0 },
      { 'date' => '2014-03-16', 'cohort' => 'A', 'result' => 0 },
      { 'date' => '2014-03-16', 'cohort' => 'A', 'result' => 0 },
      { 'date' => '2014-03-16', 'cohort' => 'A', 'result' => 0 },
      { 'date' => '2014-03-15', 'cohort' => 'A', 'result' => 1 },
      { 'date' => '2014-03-15', 'cohort' => 'A', 'result' => 1 },
      { 'date' => '2014-03-15', 'cohort' => 'A', 'result' => 0 },
      { 'date' => '2014-03-15', 'cohort' => 'A', 'result' => 0 },
      { 'date' => '2014-03-14', 'cohort' => 'A', 'result' => 0 },
      { 'date' => '2014-03-14', 'cohort' => 'A', 'result' => 0 },
      { 'date' => '2014-03-13', 'cohort' => 'A', 'result' => 1 },
    ]
  end

  let(:cohort_b) do
    [
      { 'date' => '2014-03-13', 'cohort' => 'B', 'result' => 1 },
      { 'date' => '2014-03-18', 'cohort' => 'B', 'result' => 0 },
      { 'date' => '2014-03-17', 'cohort' => 'B', 'result' => 1 },
      { 'date' => '2014-03-19', 'cohort' => 'B', 'result' => 0 },
      { 'date' => '2014-03-18', 'cohort' => 'B', 'result' => 0 },
      { 'date' => '2014-03-18', 'cohort' => 'B', 'result' => 0 },
      { 'date' => '2014-03-16', 'cohort' => 'B', 'result' => 1 },
      { 'date' => '2014-03-16', 'cohort' => 'B', 'result' => 0 },
      { 'date' => '2014-03-15', 'cohort' => 'B', 'result' => 0 },
      { 'date' => '2014-03-14', 'cohort' => 'B', 'result' => 0 },
      { 'date' => '2014-03-13', 'cohort' => 'B', 'result' => 0 },
      { 'date' => '2014-03-20', 'cohort' => 'B', 'result' => 0 },
      { 'date' => '2014-03-20', 'cohort' => 'B', 'result' => 1 },
      { 'date' => '2014-03-19', 'cohort' => 'B', 'result' => 0 },
      { 'date' => '2014-03-18', 'cohort' => 'B', 'result' => 1 },
      { 'date' => '2014-03-18', 'cohort' => 'B', 'result' => 0 },
      { 'date' => '2014-03-18', 'cohort' => 'B', 'result' => 1 },
      { 'date' => '2014-03-19', 'cohort' => 'B', 'result' => 0 },
      { 'date' => '2014-03-19', 'cohort' => 'B', 'result' => 1 },
      { 'date' => '2014-03-20', 'cohort' => 'B', 'result' => 1 },
      { 'date' => '2014-03-20', 'cohort' => 'B', 'result' => 1 },
      { 'date' => '2014-03-20', 'cohort' => 'B', 'result' => 1 },
    ]
  end
  let(:ab_tester) { ABTester.new(cohort_visits) }

  describe '#initialize' do
    it 'accepts and assigns arg of data array to variable' do
      expect(ab_tester.all_visits).to eq cohort_visits
    end
  end

  describe '#conversion_rate' do
    it 'computes conversion rate for cohort A' do
      expect(ab_tester.conversion_rate(cohort_a)).to eq 3 / 20.to_f
    end
    it 'computes conversion rate for cohort B' do
      expect(ab_tester.conversion_rate(cohort_b)).to eq 10 / 22.to_f
    end
  end

  describe '#cohort_by_name' do
    it 'creates a subset of cohorts based on name' do
      expect(ab_tester.cohort_by_name('A')).to match_array(cohort_a)
    end
  end

  describe '#conversions' do
    it 'sums of cohort A where result = 1' do
      expect(ab_tester.conversions(cohort_a)).to eq 3
    end
    it 'sums of cohort B where result = 1' do
      expect(ab_tester.conversions(cohort_b)).to eq 10
    end
  end

  describe '#chi_square' do
    it 'Confidence level the current leader is in fact better than random.' do
      expect(ab_tester.chi_square(cohort_a, cohort_b)).to be_within(2).of(97)
    end
  end
end
