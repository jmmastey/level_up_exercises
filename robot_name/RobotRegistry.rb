class RobotRegistry

  @@registry

  def self.get_registered_robots
    @@registry
  end

  def self.add_robot_to_registry(name)
    @@registry ||= []
    raise NameCollisionError, "Improper robot name!" unless proper_name?(name)
    @@registry << name unless robot_registered?(name)
  end

  def self.proper_name?(name)
    name =~ /[[:alpha:]]{2}[[:digit:]]{3}/
  end

  def self.robot_registered?(name)
    @@registry.include?(name)
  end
end