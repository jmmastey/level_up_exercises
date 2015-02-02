require 'uri'
require 'active_record'
db = URI.parse('postgres://sastaputhra:@localhost/yadda_development')

@connection = ActiveRecord::Base.establish_connection(
  :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
  :host     => db.host,
  :username => db.user,
  :password => db.password,
  :database => db.path[1..-1],
  :encoding => 'utf8'
)