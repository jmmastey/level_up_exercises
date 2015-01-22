require './spec/spec_helper.rb'

describe DinoCsv do
  let(:files) { ["./african_dinosaur_export.csv", "./dinodex.csv"] }
  let(:dino_csv) { DinoCsv.new(files) }

  describe "#attr_accessor" do
    it { expect(dino_csv).to have_attr_accessor(:results) }
  end

  describe "#initialize" do
    it "initializes a new object" do
      expect(dino_csv).to be_a(DinoCsv)
    end
  end

  describe "#parse" do
    context "when the file is located" do
      let(:file) { ["./african_dinosaur_export.csv", "./dinodex.csv"].sample }
      let(:dino_csv_parse) { dino_csv.parse(file) }
      it "returns an array" do
        expect(dino_csv_parse).to be_a(Array)
      end
      it "returns an non empty array" do
        expect(dino_csv_parse).to_not be_empty
      end
    end
    context "wen the file can not be located" do
      let(:file) { ["./to_my_alient.csv", "./to_my_monkey.csv"] }
      it "raises an error" do
        expect { dino_csv.parse(file) }.to raise_error
      end
    end
  end

  describe "#process_csv_data" do
    let(:dino_csv_process_csv_data) { dino_csv.process_csv_data(obj) }
    context "the object is nil" do
      let(:obj) { nil }
      it "returns nil" do
        expect(dino_csv_process_csv_data).to be_nil
      end
    end
    context "when the object is not nil" do
      context "when array[0] = :continent" do
        context "when array[1] is not nil" do
          let(:obj) { [:continent, 'Europe'] }
          it "downcases the value" do
            expect(dino_csv_process_csv_data).to eq(obj[1].downcase)
          end
        end
        context "when array[1] is nil" do
          let(:obj) { [:continent, nil] }
          it "returns nil" do
            expect(dino_csv_process_csv_data).to be_nil
          end
        end
      end
      context "when array[0] = :carnivore" do
        context "when array[1] is not nil" do
          context "when array[1] == yes" do
            let(:obj) { [:carnivore, "yes"] }
            it "returns carnivore" do
              expect(dino_csv_process_csv_data).to eq("carnivore")
            end
          end
          context "when not array[1] == yes" do
            let(:obj) { [:carnivore, "no"] }
            it "returns non-carnivore" do
              expect(dino_csv_process_csv_data).to eq("non-carnivore")
            end
          end
        end
        context "when array[1] is nil " do
          let(:obj) { [:carnivore, nil] }
          it "returns nil" do
            expect(dino_csv_process_csv_data).to be_nil
          end
        end
      end
      context "when array[0] = :weight_in_lbs || :weight" do
        context "when array[0] = :weight_in_lbs" do
          context "when array[1] is not nil" do
            let(:obj) { [:weight_in_lbs, "2222"] }
            it "converts the string to integer" do
              expect(dino_csv_process_csv_data).to be_a(Integer)
            end
          end
          context "wen array[1] is nil" do
            let(:obj) { [:weight_in_lbs, nil] }
            it "returns nil" do
              expect(dino_csv_process_csv_data).to be_nil
            end
          end
        end
      end
      context "when array[0] = :name || :genus || :period || :diet || :description" do
        context "when array[0] == :name" do
          context "when array[1] is not nil" do
            let(:obj) { [:name, 'Svajone'] }
            it "downcases the value" do
              expect(dino_csv_process_csv_data).to eq(obj[1].downcase)
            end
          end
          context "when array[1] is nil" do
            let(:obj) { [:name, nil] }
            it "returns nil" do
              expect(dino_csv_process_csv_data).to be_nil
            end
          end
        end
        context "when array[0] == :genus" do
          context "when array[1] is not nil" do
            let(:obj) { [:genus, 'Svajonecius'] }
            it "downcases the value" do
              expect(dino_csv_process_csv_data).to eq(obj[1].downcase)
            end
          end
          context "when array[1] is nil" do
            let(:obj) { [:genus, nil] }
            it "returns nil" do
              expect(dino_csv_process_csv_data).to be_nil
            end
          end
        end
        context "when array[0] == :period" do
          context "when array[1] is not nil" do
            let(:obj) { [:period, 'Svajonecius Period'] }
            it "downcases the value" do
              expect(dino_csv_process_csv_data).to eq(obj[1].downcase)
            end
          end
          context "when array[1] is nil" do
            let(:obj) { [:period, nil] }
            it "returns nil" do
              expect(dino_csv_process_csv_data).to be_nil
            end
          end
        end
        context "when array[0] == :diet" do
          context "when array[1] is not nil" do
            let(:obj) { [:diet, 'Svajonecius Diet'] }
            it "downcases the value" do
              expect(dino_csv_process_csv_data).to eq(obj[1].downcase)
            end
          end
          context "when array[1] is nil" do
            let(:obj) { [:diet, nil] }
            it "returns nil" do
              expect(dino_csv_process_csv_data).to be_nil
            end
          end
        end
        context "when array[0] == :description" do
          context "when array[1] is not nil" do
            let(:obj) { [:description, 'Svajonecius Diet is Da bomb'] }
            it "downcases the value" do
              expect(dino_csv_process_csv_data).to eq(obj[1].downcase)
            end
          end
          context "when array[1] is nil" do
            let(:obj) { [:description, nil] }
            it "returns nil" do
              expect(dino_csv_process_csv_data).to be_nil
            end
          end
        end
      end
    end
  end

  describe "#file_exists?" do
    context "when the file is located" do
      let(:file) { ["./african_dinosaur_export.csv", "./dinodex.csv"].sample }
      it "returns true" do
        expect(dino_csv.file_exists?(file)).to be_truthy
      end
    end
    context "when the file is not located" do
      let(:file) { ["./to_my_alient.csv", "./to_my_monkey.csv"].sample }
      it "return false if files does not exists" do
        expect(dino_csv.file_exists?(file)).to be_falsey
      end
    end
  end

  describe "#assign_continent_from_file_name" do
    let(:dino_csv_assign_continent_from_file_name) { dino_csv.assign_continent_from_file_name(file) }
    context "when it matches a continent" do
      let(:file) { "./african_dinosaur" }
      it "returns the continent" do
        expect(dino_csv_assign_continent_from_file_name).to eq('africa')
      end
    end
    context "when it does not match a continent" do
      let(:file) { "./svajone_files.csv" }
      it "returns nil" do
        expect(dino_csv_assign_continent_from_file_name).to be_nil
      end
    end
  end
end

describe FormatCsvData do
  let(:data) { 'I AM SVAJONE' }
  let(:format_csv_data) { FormatCsvData.new(data) }

  describe "#initialize" do
    it "initializes a new object" do
      expect(format_csv_data).to be_a(FormatCsvData)
    end
    it "accepts an argument" do
      expect(format_csv_data).to receive(:data)
      format_csv_data.data
    end
  end

  describe "#to_integer" do
    context "when the argument is a Numeric string" do
      let(:data) { rand(5..10) }
      it "changes a convertable string to an integer" do
        expect(format_csv_data.to_integer).to be_a(Integer)
      end
    end
    context "when the argument is not a Numeric string" do
      let(:data) { 'I AM SVAJONE' } # I realize I didn ot have to keep repeating this but I AM SVAJONE :)
      it "raises an error" do
        expect { format_csv_data.to_integer }.to raise_error
      end
    end
  end

  describe "#to_lowercase" do
    it "downcases a value" do
      upper_case = 'I AM SVAJONE'
      lowercase = format_csv_data.to_lowercase
      expect(lowercase).to_not eq(upper_case)
      expect(lowercase).to eq('i am svajone')
    end
  end

  describe "#is_i?" do
    context "when the :data is a numeric string" do
      let(:data) { [rand(5..10), "+#{rand(5..10)}", "-#{rand(5..10)}"].sample }
      it "returns true" do
        expect(format_csv_data.is_i?).to be_truthy
      end
    end
    context "when the :data is not a numeric string" do
      let(:data) { 'I AM SVAJONE 333' }
      it "returns false" do
        expect(format_csv_data.is_i?).to be_falsey
      end
    end
  end
end
