require 'spec_helper'
require_relative 'p_alpha_table'

describe 'PAlphaTable' do
  extend PAlphaTable
  it 'the error raised when degree of freedom is not exsit' do
    expect { PAlphaTable.significance_level(0, 0) }.to raise_error(RuntimeError)
    expect { PAlphaTable.significance_level(6, 0) }.to raise_error(RuntimeError)
  end
  context 'when method call with expected parameters' do
    it 'has significance level of 0' do
      expect(PAlphaTable.significance_level(1, 0.454)).to eq(0)
    end
    it 'has significance level of 0.001' do
      expect(PAlphaTable.significance_level(5, 21)).to eq(0.001)
    end
  end
end
