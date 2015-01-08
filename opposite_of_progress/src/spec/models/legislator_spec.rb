require 'rails_helper'

RSpec.describe Legislator, :type => :model do
  let(:legislator) { FactoryGirl.build(:legislator) }
  let(:senator) { FactoryGirl.build(:senator) }
  let(:representative) { FactoryGirl.build(:representative) }
  let(:titles) { %w(Sen Rep Del Com) }

  context "any legislator" do
    let(:subject) { legislator }

    it { is_expected.to validate_presence_of :bioguide_id }
    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_presence_of :last_name }
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :party }
    it { is_expected.to validate_presence_of :state }
    it { is_expected.to validate_presence_of :chamber }
    it { is_expected.to validate_inclusion_of(:title).in_array(titles) }
  end

  context '#long_title' do
    it "displays long title for title Rep" do
      legislator.title = 'Rep'
      expect(legislator.long_title).to eq('Representative')
    end

    it "displays long title for title Sen" do
      legislator.title = 'Sen'
      expect(legislator.long_title).to eq('Senator')
    end
  end

  context '#party' do
    it "displays long party name for R" do
      legislator.party = 'R'
      expect(legislator.long_party).to eq('Republican')
    end

    it "displays long party name for D" do
      legislator.party = 'D'
      expect(legislator.long_party).to eq('Democratic')
    end
  end

  context "#name" do
    let(:legislator) do
      FactoryGirl.build(:legislator, first_name: "John",
        last_name: "Williams", middle_name: nil, name_suffix: nil)
    end

    it "displays the name when there are first_name and last_name" do
      expect(legislator.name).to eq("John Williams")
    end

    it "displays the name when there is middle name" do
      legislator.middle_name = "Victor"
      expect(legislator.name).to eq("John V. Williams")
    end

    it "displays the name when there is name name_suffix" do
      legislator.name_suffix = "Jr."
      expect(legislator.name).to eq("John Williams Jr.")
    end
  end

  context '#readable_district' do
    it 'displays ordianalized district when > 1' do
      representative.district = 3
      expect(representative.readable_district).to eq('3rd')
    end

    it 'displays at-large district when = 0' do
      representative.district = 0
      expect(representative.readable_district).to eq('At-Large')
    end
  end

  context "when legislator is a senator" do
    let(:subject) { senator }

    it { is_expected.to be_senator }
    it { is_expected.not_to be_representative }

    it "is not valid without a state rank" do
      subject.state_rank = nil
      expect(subject).not_to be_valid
    end
  end

  context "when legislator is a representative" do
    let(:subject) { representative }

    it { is_expected.to be_representative }
    it { is_expected.not_to be_senator }

    it "is not valid without a district" do
      subject.district = nil
      expect(subject).not_to be_valid
    end
  end
end
