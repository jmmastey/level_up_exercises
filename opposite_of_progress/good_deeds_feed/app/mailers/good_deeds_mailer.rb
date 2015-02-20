class GoodDeedsMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.good_deeds_mailer.new_deed.subject
  #
  def new_deed
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
