class GoodDeedsMailer < ApplicationMailer
  default from: "ddzien@enova.com"

  def new_deed_notification(good_deed)
    @good_deed = good_deed
    @users = @good_deed.legislator.users.all
    @users.each do |user|
      mail to: user.email, subject: "New Deed Introduced!"
    end
  end
end
