require File.expand_path '../spec_helper.rb', __FILE__

describe 'overlord' do
  it 'should allow accessing the home page' do
    get '/'
    expect(last_response).to be_ok
  end
end