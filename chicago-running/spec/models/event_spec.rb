require 'rails_helper'

describe Event, type: :model do
  let(:params)do
    { running_type: 'running', start_date: '2015-01-01', current_page: 1 }
  end
  def num_files
    dir_path = File.join("#{Rails.root}/tmp/cache/events/", '**', '*')
    Dir.glob(dir_path).select { |file| File.file?(file) }.count
  end
  before(:each) do
    cache_path = "#{Rails.root}/tmp/cache/events/*"
    FileUtils.rm_rf(Dir.glob(cache_path))
    expect(num_files).to eq(0)
  end

  it 'the response data should be cached at 1st time' do
    data = Event.all("#{Time.now.strftime('%F')}..")
    expect(data).to be_truthy
    expect(num_files).to eq(1)
  end

  it 'cached data will be used instead if two requests are identical' do
    data_1 = Event.filter(params)
    expect(data_1).to be_truthy
    file_path_1 = Dir["#{Rails.root}/tmp/cache/events/*"][0]
    timestamp = File.mtime(file_path_1)

    data_2 = Event.filter(params)
    expect(data_2).to be_truthy
    expect(data_2).to eq(data_1)
    expect(num_files).to eq(1)
    file_path_2 = Dir["#{Rails.root}/tmp/cache/events/*"][0]
    expect(File.mtime(file_path_2)).to eq(timestamp)
  end
end
