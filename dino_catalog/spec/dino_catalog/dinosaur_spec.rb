require './spec/spec_helper.rb'

describe Dinosaur do
  let(:dinosaur) { Dinosaur.new(options) }
  let(:options) { { :name => Faker::Lorem.word,
                    :period => Faker::Lorem.word,
                    :continent => Faker::Lorem.word,
                    :diet => Faker::Lorem.word,
                    :weight => Faker::Lorem.word,
                    :ambulation => Faker::Lorem.word,
                    :description => Faker::Lorem.word
                } }

  describe "#attr_accessor" do
   [:name, :period, :continent, :diet, :weight, :ambulation, :description].each do |attribute|
     it { expect(dinosaur).to have_attr_accessor(attribute) }
    end
  end

  describe "#initialize" do
    it "initializes a new object" do
      expect(dinosaur).to be_a(Dinosaur)
    end
  end

  describe "#to_hash" do
    it "converts the object to a hash" do
      expect(dinosaur.to_hash).to be_a_kind_of(Hash)
    end
    [:name, :period, :diet, :weight, :ambulation, :description].each do |attribute|
      it "contains the key :#{attribute}" do
        expect(dinosaur.to_hash).to have_key(attribute)
      end
    end
  end
end
