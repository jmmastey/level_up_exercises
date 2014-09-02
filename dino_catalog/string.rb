require './distance'

class String
  def distance(o_str)
    Distance::edit_distance(self,o_str)
  end
end
