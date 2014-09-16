# rubocop:disable all
require_relative '../lib/robot_name.rb'
require_relative 'spec_helper.rb'

$all_robots = []
def make_robot(*args)
  robot = Robot.new(*args)
  $all_robots << robot
  robot
end

describe Robot do
  context 'stubs' do
    it 'will instantiate correctly' do
      expect(make_robot).not_to be_nil
    end
    it 'will have a name' do
      expect(make_robot.name).not_to be_empty
    end
    it 'will have a random name' do
      expect(make_robot.name).not_to eq(make_robot.name)
    end
    it 'will maintain name registry' do
      50.times { make_robot }
      registry = Robot.class_variable_get("@@registry")
      expect(registry).to eq($all_robots.collect(&:name))
    end
    it 'will raise NameCollisionError' do
      do_generate = proc do
        generator = -> { 'AA111' }
        make_robot(name_generator: generator)
        make_robot(name_generator: generator)
      end
      expect(&do_generate).to raise_error(NameCollisionError)
    end
  end
end
# rubocop:enable all
