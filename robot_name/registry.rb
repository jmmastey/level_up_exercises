class Registry
  attr_accessor :list

  def initialize(list: [])
    @list = list
  end

  def add(name)
    check_if_name_exists(name)
    list << name
  end

  private

  def check_if_name_exists(name)
    if list.include?(name)
      raise NameCollisionError, "The Robot's already in the registry!"
    end
  end
end
