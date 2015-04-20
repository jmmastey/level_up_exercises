require 'user'
require 'climate'
class WeatherMailer < ApplicationMailer

  # Send the weather to every user

  def mail_weather
    @users = User.all
    @weather = todays_weather

    @users.each do |user|
      @current_user = user
      mail to: user.email, subject: "Today's weather"
    end
  end

  private
    def todays_weather
      @weather = Climate.find_by date: Date.today, day: get_today
    end

    def get_today
      Date::DAYNAMES[Time.now.wday]
    end
end
