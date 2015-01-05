require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "DataScience::Cohort" do
  describe '#new' do
    it 'assigns its name the value passed to new' do
      cohort = DataScience::Cohort.new('foo')
      
      expect(cohort.name).to eq('foo') 
    end
  end
  
  describe '#add_sample' do
    it 'increments the number of samples by one' do
      cohort = DataScience::Cohort.new('foo')
      
      expect { cohort.add_sample }.to change{cohort.trials}.from(0).to(1)
    end
    
    context 'when a conversion took place' do
      it 'incremented converstions' do
        cohort = DataScience::Cohort.new('foo')
      
        expect { cohort.add_sample(true) }.to change{cohort.conversions}.from(0).to(1)
      end
    end
  end
end
