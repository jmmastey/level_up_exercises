class GoodDeedsMailer < ApplicationMailer

  default from: "ddzien@enova.com"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.good_deeds_mailer.new_deed.subject
  #
  def new_deed_notification(legislator)
    @greeting = "Hi"
    @users = legislator.users.all
    @users.each do |user|
      mail to: user.email, subject: "New Deed Introduced!"
    end
  end
end
