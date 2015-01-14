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

  describe "#initialize" do
    it "initializes a new object" do
      expect(dinosaur).to be_a(Dinosaur)
    end

    context "when options are passed" do
      [:name, :period, :diet, :weight, :ambulation, :description].each do |attribute|
        it "sets the #{attribute}" do
          expect(dinosaur.send(attribute)).to_not be_nil
        end
      end
    end

    context "when options are not passed" do
      let(:options) {{}}
      [:name, :period, :diet, :weight, :ambulation, :description].each do |attribute|
        it "sets the #{attribute} to nil" do
          expect(dinosaur.send(attribute)).to be_nil
        end
      end
    end
  end

  describe "#lower_case" do
    context "when an attribute is not nil" do
      it "switches the case to lower" do
        upper_case_attribute = 'HELLO MY NAME IS MAGIC MIKE'
        expect(dinosaur.lower_case(upper_case_attribute)).to_not eq(upper_case_attribute)
      end
    end
    context "when an attribute is nil" do
      it "returns false" do
        nil_attribute = nil
        expect(dinosaur.lower_case(nil_attribute)).to be_falsey
      end
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
