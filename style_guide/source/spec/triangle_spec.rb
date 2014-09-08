# rubocop:disable all
require_relative '../lib/triangle.rb'
require_relative 'spec_helper.rb'

describe Triangle do
  context 'stubs' do
    it 'will recite correct facts #1' do
      response = capture_stdout { Triangle.new(5, 5, 5).recite_facts }
      expected = [
        %{This triangle is equilateral!},
        %{The angles of this triangle are 60,60,60}
      ]
      expect(response.split("\n").collect(&:strip)).to eq(expected)
    end
    it 'will recite correct facts #2' do
      response = capture_stdout { Triangle.new(5, 12, 13).recite_facts }
      expected = [
        %{This triangle is scalene and mathematically boring.},
        %{The angles of this triangle are 23,67,90},
        %{This triangle is also a right triangle!}
      ]
      expect(response.split("\n").collect(&:strip)).to eq(expected)
    end
  end
end
# rubocop:enable all
