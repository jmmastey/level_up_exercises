class Registry
  def self.names
    @names ||= []
  end

  def self.add(name)
    @names << name
  end
end