require "figgy"

AppConfig = Figgy.build do |config|
  config.root = Rails.root.join("etc")
  config.define_overlay(:default, nil)
  config.define_overlay(:environment) { Rails.env }
end
