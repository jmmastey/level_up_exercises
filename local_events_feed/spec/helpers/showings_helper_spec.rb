require 'rails_helper'

RSpec.describe ShowingsHelper, :type => :helper do
  let(:showing_times) { [DateTime.parse('20141001T190000'), 
                         DateTime.parse('20141002T190000'), 
                         DateTime.parse('20141003T190000')] }

  let(:showings) { showing_times.map { |time| Showing.new(time: time) } }
  let(:no_showings) { [] }
  let(:one_showing) { [ Showing.new(time: DateTime.parse('20141001T190000')) ] }
  let(:one_day_showings) { [ Showing.new(time: DateTime.parse('20141001T190000')),
                             Showing.new(time: DateTime.parse('20141001T210000'))] }

  it 'can show a date range of showings' do
    expect(ShowingsHelper.pretty_date_range(showings)).to eq('Oct 1 - Oct 3, 2014')
  end

  it 'can show single-day showings date-range' do
    expect(ShowingsHelper.pretty_date_range(one_showing)).to eq('Oct 1, 2014 Only')
  end

  it 'can show an empty showings date-range' do
    expect(ShowingsHelper.pretty_date_range(no_showings)).to eq('No Showings')
  end

  it 'can show a pretty count of showings' do
    expect(ShowingsHelper.pretty_showing_count(showings)).to eq('3 Showings')
  end

  it 'can show a pretty count of empty showings' do
    expect(ShowingsHelper.pretty_showing_count(no_showings)).to eq('No Showings')
  end

  it 'can show a pretty count of one showings' do
    expect(ShowingsHelper.pretty_showing_count(one_showing)).to eq('1 Showing')
  end

  it 'can tell if a list of showings are on one day only' do
    expect(ShowingsHelper.one_day_only?(one_day_showings)).to be true
  end

  it 'can tell if a list of showings are on one day only' do
    expect(ShowingsHelper.one_day_only?(showings)).to be false
  end
end
