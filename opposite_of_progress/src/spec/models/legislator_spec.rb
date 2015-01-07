require 'rails_helper'

RSpec.describe Legislator, :type => :model do
  let(:legislator) { FactoryGirl.build(:legislator) }
  let(:senator) { FactoryGirl.build(:senator) }
  let(:representative) { FactoryGirl.build(:representative) }

  context "any legislator" do
    let(:subject) { legislator }

    titles = %w(Sen Rep Del Com)

    it { is_expected.to validate_presence_of :bioguide_id }
    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_presence_of :last_name }
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :party }
    it { is_expected.to validate_presence_of :state }
    it { is_expected.to validate_presence_of :chamber }
    it { is_expected.to validate_inclusion_of(:title).in_array(titles) }
    # it { is_expected.to have_many :sponsored_bills }
    # it { is_expected.to have_many :cosponsorships }
    # it { is_expected.to have_many :cosponsored_bills }
  end

  context "#name" do
    let(:legislator) do
      FactoryGirl.build(:legislator, first_name: "John",
        last_name: "Smith", middle_name: nil, name_suffix: nil)
    end

    it "displays the name when there are first_name and last_name" do
      expect(legislator.name).to eq("John Smith")
    end

    it "displays the name when there is middle name" do
      legislator.middle_name = "Victor"
      expect(legislator.name).to eq("John V. Smith")
    end

    it "displays the name when there is name name_suffix" do
      legislator.name_suffix = "Jr."
      expect(legislator.name).to eq("John Smith Jr.")
    end
  end

  context "#representation" do
    let(:legislator) do
      FactoryGirl.build(:legislator, state: "IL", party: "R")
    end

    it "displays the correct representation" do
      expect(legislator.representation).to eq("R-IL")
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
