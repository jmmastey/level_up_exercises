require 'test_helper'

class GoodDeedsMailerTest < ActionMailer::TestCase
  test "new_deed" do
    mail = GoodDeedsMailer.new_deed
    assert_equal "New deed", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
