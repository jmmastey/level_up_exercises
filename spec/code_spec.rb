require_relative '../lib/code'

describe Code do
  describe '#initialize' do
    context 'without any arguments' do
      it 'raises an error' do
        expect { described_class.new }.to raise_error
      end
    end
  end

  let(:number)  { '1234' }
  let(:letters) { 'abcd' }
  let(:code)    { }
  let(:type)    { }
  
  describe '#valid' do
    let(:subject) { described_class.new(code, type) }

    context 'when input is numeric' do
      let(:code) { number }

      it { should be_valid }
    end

    context 'when input is present but not numeric' do
      let(:code) { letters }

      it { should_not be_valid }
    end

    context 'when input is empty' do
      let(:code) { "" }

      it { should_not be_valid }
    end
  end

  describe '#to_s' do
    it 'returns input if self is numeric and not empty' do
      expect(described_class.new(number, "").to_s).to eq number
    end

    it 'returns nil if self is present but not numeric' do
      expect(described_class.new(letters, "").to_s).to be_nil
    end

    context 'with self empty' do
      it 'returns the default value' do
        expect(described_class.new("", :activation_code).to_s).to eq '1234'
        expect(described_class.new("", :deactivation_code).to_s).to eq '0000'
        expect(described_class.new("", :countdown).to_s).to eq '30'
      end
    end
  end
end