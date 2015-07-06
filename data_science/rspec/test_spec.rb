require '../data_science.rb'


describe DataScience do
  before :all do 
    data_file = '../data_export_2014_06_20_15_59_02.json'
    @ds = DataScience.new(data_file);
  end

  it "should have the correct sample size" do
    @ds.sample_size.should == 2892
  end

  it "should have two cohorts" do
    @ds.cohorts.count.should == 2
  end

  it "should report the correct cohort sample sizes" do
    a_stats = @ds.cohort_stats('A')
    a_stats[1].should == 1349

    b_stats = @ds.cohort_stats('B')
    b_stats[1].should == 1543
  end

  it "should report the correct cohort conversions" do
    a_stats = @ds.cohort_stats('A')
    a_stats[0].should == 47

    b_stats = @ds.cohort_stats('B')
    b_stats[0].should == 79
  end

  it "should report the correct mean & error" do
    a_stats = @ds.calc_mean_error('A')
    (a_stats[0] - 0.034841).abs.should <= 0.00001
    (a_stats[1] - 0.006820).abs.should <= 0.00001

    b_stats = @ds.calc_mean_error('B')
    (b_stats[0] - 0.051199).abs.should <= 0.00001
    (b_stats[1] - 0.008197).abs.should <= 0.00001
  end

  it "should report the correct confidence intervals" do
    a_stats = @ds.calc_confidence('A')
    (a_stats[0] - 0.028).abs.should <= 0.01
    (a_stats[1] - 0.035).abs.should <= 0.01
    (a_stats[2] - 0.042).abs.should <= 0.01

    b_stats = @ds.calc_confidence('B')
    (b_stats[0] - 0.043).abs.should <= 0.01
    (b_stats[1] - 0.051).abs.should <= 0.01
    (b_stats[2] - 0.059).abs.should <= 0.01
  end
end