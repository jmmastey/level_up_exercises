# TODO: GO FULL META (via const_missing/autoload)
Dir[File.dirname(__FILE__) + '/lib/**/**.rb'].each { |file| require file }
