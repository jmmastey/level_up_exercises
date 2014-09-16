PROJECT_ROOT = File.dirname(__FILE__)
$LOAD_PATH.unshift(PROJECT_ROOT)
Dir["#{PROJECT_ROOT}/lib/**/**.rb"].each do |file|
  require file
end
