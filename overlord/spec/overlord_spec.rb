require_relative 'spec_helper'

describe 'overlord' do
  it 'should allow accessing the home page' do
    get '/'
    expect(last_response).to be_ok
  end
end