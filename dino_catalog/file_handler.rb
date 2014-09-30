require 'csv'

class FileHandler
  attr_accessor :file_name, :headers, :contents

  def initialize(file_name)
    @contents = CSV.read(file_name, { headers: true,
                                      encoding: "UTF-8", })
  end

  def get_all_objects
    objects = []

    @contents.each do |content|
      objects << map_to_object(content)
    end

    objects
  end
end
