module JsonExport

  def convert_to_json(ruby_object)
    array_of_objects = convert_object_to_array(ruby_object)
    File.open("json_export.json", "w") do |f|
      f.puts JSON.generate(array_of_objects)
    end
  end

  def convert_object_to_array(object)
    object.inject([]) { |array, attribute| array << attribute.to_hash }
  end

end
