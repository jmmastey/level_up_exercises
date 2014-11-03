module ApplicationHelper
  API_BASE_PATH = "https://congress.api.sunlightfoundation.com/"
  API_KEY = "2d3136f6874046c8ba34d5e2f1a96b03"
  API_PAGE_COUNT = "50"

  def self.to_md5_hash(obj)
    md5 = Digest::MD5.new
    md5.update ""

    unless obj.nil?
        obj.attributes.each do |key,_|
          md5 << obj[key].to_s unless key == "id"
        end
    end

    md5.hexdigest
  end
end
