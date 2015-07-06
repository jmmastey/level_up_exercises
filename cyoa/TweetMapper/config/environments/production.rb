Rails.application.configure do
  config.action_controller.perform_caching = true
  config.active_record.dump_schema_after_migration = false
  config.active_support.deprecation = :notify
  config.assets.js_compressor = :uglifier
  config.assets.css_compressor = :sass
  config.assets.compile = false
  config.assets.digest = true
  config.cache_classes = true
  config.consider_all_requests_local = false
  config.eager_load = true
  config.log_formatter = ::Logger::Formatter.new
  config.log_level = :debug
  config.serve_static_files = true
end
