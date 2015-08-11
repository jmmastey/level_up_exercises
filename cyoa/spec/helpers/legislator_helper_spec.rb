require 'rails_helper'

describe LegislatorHelper, type: :helper do
  describe '#verbose_summary' do
    context 'when there is a delegate' do
      before { @legislator = build(:legislator, title: 'Del', state: 'IL') }

      it 'returns delegate summary' do
        expect(helper.verbose_summary).to include("for Illinois At Large")
      end
    end

    context 'when there is a representative with no district' do
      before { @legislator = build(:legislator, title: 'Rep', district: '0', state: 'IL') }

      it 'returns delegate summary' do
        expect(helper.verbose_summary).to include("for Illinois At Large")
      end
    end

    context 'when there is a representative with a district' do
      before { @legislator = build(:legislator, title: 'Rep', district: '13', state: 'IL') }

      it 'returns delegate summary' do
        expect(helper.verbose_summary).to include("for Illinois's 13th congressional district")
      end
    end

    context 'when there is a senator' do
      before { @legislator = build(:legislator, title: 'Sen', state: 'IL') }

      it 'returns delegate summary' do
        expect(helper.verbose_summary).to include("from Illinois")
      end
    end
  end

  describe '#full_leadership_role' do
    context 'when there is no leadership role' do
      before { @legislator = build(:legislator, leadership_role: nil) }

      it 'returns nil' do
        expect(helper.full_leadership_role).to be_nil
      end
    end

    context 'when the role is Speaker' do
      before { @legislator = build(:legislator, leadership_role: 'Speaker') }

      it 'returns Speaker of the House' do
        expect(helper.full_leadership_role).to eq('Speaker of the House')
      end
    end

    context 'when there is a leadership role' do
      before { @legislator = build(:legislator, leadership_role: 'Minority Leader') }

      it 'returns leader of the House' do
        expect(helper.full_leadership_role).to eq('House Minority Leader')
      end
    end
  end

  describe '#bioguide_url' do
    context 'when there is no bioguide id' do
      before { @legislator = build(:legislator, bioguide_id: nil) }

      it 'returns an empty url' do
        expect(helper.bioguide_url).to eq('#')
      end
    end

    context 'when there is a bioguide id' do
      before { @legislator = build(:legislator, bioguide_id: 1) }

      it 'returns the votesmart url' do
        expect(helper.bioguide_url).to include('bioguide.congress.gov')
      end
    end
  end

  describe '#votesmart_url' do
    context 'when there is no votesmart id' do
      before { @legislator = build(:legislator, votesmart_id: nil) }

      it 'returns an empty url' do
        expect(helper.votesmart_url).to eq('#')
      end
    end

    context 'when there is a votesmart id' do
      before { @legislator = build(:legislator, votesmart_id: 1) }

      it 'returns the votesmart url' do
        expect(helper.votesmart_url).to include('votesmart.org')
      end
    end
  end

  describe '#age' do

  end

  describe '#legislator_full_title' do
    context 'expands Sen and' do
      before { @legislator = build(:legislator, title: 'Sen') }

      it 'shows Senator' do
        expect(helper.legislator_full_title).to eq('Senator')
      end
    end

    context 'expands Rep and' do
      before { @legislator = build(:legislator, title: 'Rep') }

      it 'shows Representative' do
        expect(helper.legislator_full_title).to eq('Representative')
      end
    end
  end

  describe '#full_party' do
    context 'expands D and' do
      before { @legislator = build(:legislator, party: 'D') }

      it 'shows Democrat' do
        expect(helper.full_party).to eq('Democrat')
      end
    end

    context 'expands R and' do
      before { @legislator = build(:legislator, party: 'R') }

      it 'shows Republican' do
        expect(helper.full_party).to eq('Republican')
      end
    end
  end

  describe '#legislator_name' do
    context 'when there is a middle name' do
      before { @legislator = build(:legislator, first_name: 'Tom', middle_name: 'Marvolo', last_name: 'Riddle') }

      it 'shows the name' do
        expect(helper.legislator_name).to eq('Tom Marvolo Riddle')
      end
    end

    context 'when there is no middle name' do
      before { @legislator = build(:legislator, first_name: 'Jon', middle_name: nil, last_name: 'Snow') }

      it 'shows the name' do
        expect(helper.legislator_name).to eq('Jon Snow')
      end
    end
  end
end
