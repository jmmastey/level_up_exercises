require 'rails_helper'

describe 'Transaction' do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:bank_transaction, amount: 10)).to be_valid
  end

  it 'is invalid without a date' do
    expect(FactoryGirl.build(:bank_transaction, date: nil)).to_not be_valid
  end

  it 'is invalid without an amount' do
    expect(FactoryGirl.build(:bank_transaction, amount: nil)).to_not be_valid
  end

  it 'is invalid without a term_id' do
    expect(FactoryGirl.build(:bank_transaction, term_id: nil)).to_not be_valid
  end

  it 'is invalid without a transaction type' do
    expect(FactoryGirl.build(:bank_transaction, transaction_type: nil)).to_not be_valid
  end
end
