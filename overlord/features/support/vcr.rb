require 'vcr'

VCR.configure do |c|
  c.ignore_localhost = true
end