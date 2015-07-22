require 'spec_helper'
require 'data_point'

describe DataPoint do
  let(:data_point) { DataPoint.new(foo: 1, bar: "bar", baz: nil) }

  context "when there is a value associated with a measure" do
    it "can return the value" do
      expect(data_point.value(:foo)).to be(1)
    end
  end

  context "when an unknown measure is requested" do
    it "returns nil" do
      expect(data_point.value(:hamburger)).to be_nil
    end
  end

  context "when the requirements hash is empty" do
    it ".match? returns true" do
      expect(data_point.match?({})).to be true
    end
  end

  context "when there is only one requirement" do
    context "when it matches" do
      it ".match? returns true" do
        expect(data_point.match?(foo: 1)).to be true
      end
      context "and nil is a required value" do
        it ".match? returns true" do
          expect(data_point.match?(baz: nil)).to be true
        end
      end
    end
    context "when it does not match the hash requirement" do
      context "because the value does not match" do
        it ".match? returns false" do
          expect(data_point.match?(foo: 2)).to be false
        end
      end
      context "because the attribute is not present" do
        it ".match? returns false" do
          expect(data_point.match?(nope: 2)).to be false
        end
      end
    end
  end

  context "when there are two requirements" do
    context "when it matches both requirements" do
      it ".match? returns true" do
        expect(data_point.match?(foo: 1, bar: "bar")).to be true
      end
    end
    context "when it only matches one requirement" do
      it ".match? returns false" do
        expect(data_point.match?(foo: 1, bar: "fred")).to be false
      end
    end
  end

  context "when key/value pairs are the same" do
    let(:data_point_1) { DataPoint.new(foo: 1, bar: "bar", baz: nil) }
    let(:data_point_2) { DataPoint.new(foo: 1, bar: "bar", baz: nil) }
    it ".eql? returns true" do
      expect(data_point_1.eql?(data_point_2)).to be true
    end
  end
end
