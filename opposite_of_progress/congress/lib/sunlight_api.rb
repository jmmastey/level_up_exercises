# Helper class for Sunlight API calls
class SunlightAPI
  def self.request_data(obj_name, match_key = nil)
    base_url = self.get_base_url(obj_name)
    (1..20).each do |num|
      data = self.request_resource("#{base_url}&page=#{num}")
      self.process_response_objs(obj_name, data, match_key)
    end
  end

  private

  def self.get_base_url(obj_name)
    "#{ENV["API_BASE_PATH"]}#{obj_name.pluralize.downcase}?apikey=#{ENV["API_KEY"]}" \
      "&per_page=#{ENV["API_PAGE_COUNT"]}"
  end

  def self.request_resource(path)
    Curl.get(path)
  end

  def self.process_response_objs(class_name, raw_json_data, match_key)
    match_key = "#{class_name.downcase}_id" if match_key.nil?
    klass = class_name.constantize
    @results = JSON.parse(raw_json_data.body_str)

    @results["results"].each do |result|
      obj = klass.find_or_create_by(match_key => result[match_key])
      obj.update(klass.build_object_hash(result))
    end
  end
end