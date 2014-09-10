# TODO: GO FULL META (via const_missing/autoload)
work_dir = Dir[File.dirname(__FILE__)]
$:.unshift(work_dir)
Dir["#{File.dirname(__FILE__)}/lib/**/**.rb"].each do |file|
  require file
end