module TestConstants
  def status
    status = {}
    status["activation_code"] = {}
    status["deactivation_code"] = {}
    status["activation_code"]["button"] = "Activate"
    status["deactivation_code"]["button"] = "Deactivate"
    status
  end
end

World(TestConstants)
