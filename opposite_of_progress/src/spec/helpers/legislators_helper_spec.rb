require 'rails_helper'

RSpec.describe LegislatorsHelper, :type => :helper do
  context '#link_to_legislator' do
    it 'calls link_to with correct formats' do
      legislator = double('legislator', title: 'Rep', name: 'John Smith')
      name_with_title = [legislator.title, legislator.name].join(". ")
      options = double('options')

      allow(helper).to receive(:link_to)
      helper.link_to_legislator(legislator, options)
      expect(helper).to have_received(:link_to).with(name_with_title, legislator, options)
    end
  end

  context '#represenation_tag' do
    it 'calls content tag with correct parameters' do
      legislator = double('legislator', state: 'IL',
        readable_district: '5th', long_title: 'Representative')
      options = double('options')
      text = "Representative for Illinois 5th District"

      allow(States).to receive(:abbr_to_state).and_return('Illinois')
      allow(legislator).to receive(:senator?).and_return(false)
      allow(helper).to receive(:content_tag)

      helper.representation_tag(legislator, options)
      expect(helper).to have_received(:content_tag).with(:div, text, options)
    end
  end

  context '#party_tag' do
    it 'calls content_tag with long_party name' do
      legislator = double('legislator', long_party: 'Republican')
      options = {}

      allow(helper).to receive(:content_tag)

      helper.party_tag(legislator, options)
      expect(helper).to have_received(:content_tag)
        .with(:div, legislator.long_party, options)
    end
  end
end
