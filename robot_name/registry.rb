class Registry
  attr_accessor :list

  def initialize(type:, list: [])
    @type = type
    @list = list
  end

  def include?(string)
    list.include?(string)
  end
end
