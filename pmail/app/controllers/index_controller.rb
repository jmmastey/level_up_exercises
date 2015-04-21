require 'active_support'

class IndexController < ApplicationController
  def index
    @messages = make_fake_messages
  end

  def make_fake_messages
    message_bodys = [
      'Wow email is such a cool technology!!! it is amazing how far society has come to allow some cooooooool technology blahblahblah omg owwieorjweor wewro wo weo waow waow waaaoowwwwwwwww',
      'Something something phishing email... nigerian prince, gibe moni or i report x) X)X X)X )X )X )X X) ) hahadslfkajdsflkdsafjafhgaghag',
      'Release snapshot something something important important production staging words, more words, work work work work work haha lol work x) )) ()()( )()',
      'Buzzwords buzzwords buzzwords buzzwords AGILE SCRUM RAILS RUBY SYNERGY WATERFALL TDD BDD TEST DRIVEN SOMETHING DRIVEN AB TESTING BOILERPLATE BOOTSTRAP',
      'Something about viagra or something lelleelelel pills prescription pills Rx rx xrr xr xr xr xr xrx rxr xrx rxr xr cheap $0.12/pill waow x)'
    ]

    message_subjects = [
      'ASAP',
      'WFH',
      'ACRONYM',
      'Cheap pills',
      'Money for a friendo????',
      'Daaaaaaaaaaaaaaaaank',
      'OOO',
      'messages are cool',
      'No subject',
      'Rx viagra cheap',
      'sick day x(',
      'funny images pt 1',
      'funny images pt 2'
    ]

    message_sender = [
      'John Doe',
      'Jane Doe',
      'Chris Christie',
      'Hilary Clinton',
      'Ron Paul',
      'Ayy, Lmao',
      'tazdingo',
      'grooby doo',
      'shaaaloow dootooloo',
      'keanue rieves',
      'mister matrix man',
      'tyrone',
      'ur mom xD'
    ]

    message_time = [
      Date.today,
      Date.yesterday,
      Date.today - 2.days,
      Date.today - 3.days,
      Date.today - 4.days,
      Date.today - 5.days
    ]

    messages = []
    30.times do
      messages << {
        body: message_bodys.sample,
        subject: message_subjects.sample,
        sender: message_sender.sample,
        time: message_time.sample.strftime("%b %d")
      }
    end

    messages
  end
end
