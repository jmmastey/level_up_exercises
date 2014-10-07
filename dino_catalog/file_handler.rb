require "csv"

class FileHandler
  attr_accessor :file_name, :contents

  def initialize(file_name)
    @contents = CSV.read(file_name, headers: true,
                                    encoding: "UTF-8",
                                    header_converters: header_converters,
                                    converters: content_converters)
  end

  def all_objects
    @contents.map { |content| map_to_object(content) }
  end
end
