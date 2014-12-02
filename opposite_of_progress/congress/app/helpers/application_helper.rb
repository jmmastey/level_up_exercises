# Application helper module
module ApplicationHelper
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
