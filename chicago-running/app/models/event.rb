require 'digest/md5'
module Event
  URL = 'http://api.amp.active.com/v2/search?api_key=kgcewj4x9bebd56kf3u8n24w'\
        '&category=event&near=Chicago,IL,US&radius=25&exclude_children=true'\
        '&per_page=10&sort=date_asc'
  CACHE_LIFE_CYCLE = 864_00

  def self.all(date)
    data = fetch("#{URL}&query=running&start_date=#{date}", CACHE_LIFE_CYCLE)
    return false if data.nil?
    data = File.read(data) if data.is_a?(File)
    JSON.parse(data)
  end

  def self.filter(option = {})
    params = option.map { |key, value| "#{key}=#{value}" }.join('&')
    data = fetch("#{URL}&#{params}", CACHE_LIFE_CYCLE)
    return false if data.nil?
    data = File.read(data) if data.is_a?(File)
    JSON.parse(data)
  end

  private

  def self.fetch(url, max_age = 0)
    cache_path = "#{Rails.root}/tmp/cache/events"
    FileUtils.mkdir_p cache_path unless Dir.exists?(cache_path)
    file = Digest::MD5.hexdigest(url)
    file_path = File.join('', cache_path, file)
    return File.new(file_path).read if verify_file?(file_path, max_age)
    response = HTTParty.get(url).response
    save_file(file_path, response.body) if response.code.to_i == 200
  end

  def self.verify_file?(file_path, file_life_cycle)
    return false unless File.exist?(file_path)
    Time.now - File.mtime(file_path) < file_life_cycle
  end

  def self.save_file(file_path, response_data)
    File.open(file_path, 'w') { |data| data << response_data }
  end
end
