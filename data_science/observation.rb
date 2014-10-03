class Observation
  attr_reader :subject, :success

  def initialize(subject, success)
    @subject = subject
    @success = success
  end
end
