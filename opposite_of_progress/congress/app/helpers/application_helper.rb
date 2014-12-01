# Application helper module
module ApplicationHelper
  API_BASE_PATH = "https://congress.api.sunlightfoundation.com/"
  API_KEY = "2d3136f6874046c8ba34d5e2f1a96b03"
  API_PAGE_COUNT = "50"
  PAGINATION_COUNT = "10"

  def self.to_md5_hash(obj, empty_obj = obj.class.new)
    md5 = Digest::MD5.new
    md5.update ""

    unless obj.nil?
      empty_obj.attributes.each do |key, _|
        md5 << obj[key].to_s unless key == "id"
      end
    end

    md5.hexdigest
  end

  def self.fetch(class_name, raw_json_data, match_key = nil)
    match_key = "#{class_name.downcase}_id" if match_key.nil?
    klass = class_name.constantize
    @results = JSON.parse(raw_json_data.body_str)

    @results["results"].each do |result|
      obj = klass.find_or_create_by(match_key => result[match_key])
      obj.update(klass.build_object_hash(result))
    end
  end

  def self.pull_resource(path)
    Curl.get(path)
  end
end
