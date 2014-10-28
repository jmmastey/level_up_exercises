module JsonExport

  def convert_to_json(ruby_object)
    ruby_object_length = ruby_object.size
    File.open("json_export.json", "w") do |f|
      ruby_object.each_with_index do |object, index|
        f.print JSON.generate(object.to_hash)
        f.puts ',' unless index == (ruby_object_length - 1)
      end
    end
  end

end
