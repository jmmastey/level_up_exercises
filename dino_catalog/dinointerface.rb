require './dinodex'

class DinoInterface
  PROMPT_MESSAGES = {
    exit: "Goodbye! Thanks for playing.",
    no_results: "No dinos matched your search.",
    results: "Dinos that matched your results: ",
    start: "Welcome! What follows is a list of questions that will be used to generate a list of dinosaurs that match your criteria. Ready? (Y/n)",
  }
  QUESTIONS = [
    {
      question: "How many legs does the dinosaur have? (2 or 4)",
      answers: {
        '2' => 'Biped',
        '4' => 'Quadruped',
      },
      search_key: :walking,
    },
    {
      question: "Which period did the dinosaur live in? (1=Cretaceous,2=Jurassic,3=Triassic)",
      answers: {
        '1' => 'Cretaceous',
        '2' => 'Jurassic',
        '3' => 'Triassic',
      },
      search_key: :period,
    },
  ]

  def initialize
    @search_criteria = {}
    @dinodex = DinoDex.new
  end

  def start
    p PROMPT_MESSAGES[:start]
    loop do
      break unless gets.chomp.downcase == 'n'
      exit_session
    end
    ask_questions
  end

  def finish
    results = @dinodex.search(@search_criteria)
    if results.length == 0
      p PROMPT_MESSAGES[:no_results]
    else
      p PROMPT_MESSAGES[:results] + list_results(results)
    end
  end

  def list_results(results)
    output = ''
    results.each_with_index do |dino, i|
      output += dino[:name]
      output += ', ' if i < results.length - 1
    end
    output
  end

  def exit_session
    p PROMPT_MESSAGES[:exit]
    exit
  end

  def ask_questions
    QUESTIONS.each_with_index do |data, i|
      sleep(1) while @search_criteria.length < i - 1
      question(data)
    end
    finish
  end

  def question(data)
    loop do
      p data[:question]
      answer = gets.chomp.downcase
      if data[:answers].key?(answer)
        @search_criteria[data[:search_key]] = data[:answers][answer]
        break
      end
    end
  end
end
