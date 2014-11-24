# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :feedback do
    user nil
    subject "subject"
    message "message"

    factory :no_subject_feedback do
      subject ""
    end

    factory :no_message_feedback do
      subject ""
    end
  end
end
