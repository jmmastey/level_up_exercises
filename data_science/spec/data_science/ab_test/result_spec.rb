require 'pp'

require 'data_science/ab_test/result'

describe DataScience::ABTest::Result do
  let(:result) { build(:ab_test_result) }

  #
  # This test explicitly confirms the output of pretty-printing the
  # results class.  This is on purpose: the contract that this class
  # has with the outside world is how it exposes information.  Given
  # the PP interface, things like "breakable" have explicit meanings
  # and placement is very important, so we test that the output can be
  # rendered exactly as we expect.
  it 'pretty prints' do
    pp = instance_double('PrettyPrint')

    expect(pp).to receive(:text).with('A Conversions: 100/1100').ordered
    expect(pp).to receive(:breakable).ordered

    expect(pp).to receive(:text).with('A Conversion Rate (95%): 12.35% - 23.46%').ordered
    expect(pp).to receive(:breakable).ordered

    expect(pp).to receive(:text).with('B Conversions: 10000/1010000').ordered
    expect(pp).to receive(:breakable).ordered

    expect(pp).to receive(:text).with('B Conversion Rate (95%): 5.68% - 7.89%').ordered
    expect(pp).to receive(:breakable).ordered

    expect(pp).to receive(:text).with('Confidence: 95.68%').ordered

    result.pretty_print(pp)
  end
end
