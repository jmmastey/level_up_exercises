class ApplicationMailer < ActionMailer::Base
  default from: "weather@jeremyfinzel.com"
  layout 'mailer'
end
