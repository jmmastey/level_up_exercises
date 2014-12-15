require 'zeus/rails'

class CustomPlan < Zeus::Rails

  def test
    exit RSpec::Core::Runner.run(ARGV)
  end

end

Zeus.plan = CustomPlan.new
