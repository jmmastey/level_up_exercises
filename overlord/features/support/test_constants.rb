module TestConstants
  def self.status
    status = {}
    status["activation_code"] = {}
    status["deactivation_code"] = {}
    status["activation_code"]["url"]="bomb_activate"
    status["activation_code"]["button"]="Activate"

    status["deactivation_code"]["url"]="bomb_deactivate"
    status["deactivation_code"]["button"]="Deactivate"
    status
  end
end

World(TestConstants)