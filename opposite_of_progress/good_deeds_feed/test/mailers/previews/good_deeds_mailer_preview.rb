# Preview all emails at http://localhost:3000/rails/mailers/good_deeds_mailer
class GoodDeedsMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/good_deeds_mailer/new_deed
  def new_deed
    GoodDeedsMailer.new_deed
  end

end
