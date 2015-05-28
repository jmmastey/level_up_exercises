require './dinodex'
require 'pry'

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
    proceed_to_next_step
  end

  def exit_session
    p PROMPT_MESSAGES[:exit]
    exit
  end

  def proceed_to_next_step
    if @search_criteria.length >= QUESTIONS.length
      finish
    else
      ask_next_question
    end
  end

  def ask_next_question
    question = QUESTIONS[@search_criteria.length]
    p question[:question]
    answer = gets.chomp.downcase
    if question[:answers].key?(answer)
      @search_criteria[question[:search_key]] = question[:answers][answer]
    end
    proceed_to_next_step
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
    dino_names = results.map { |dino| dino[:name] }
    dino_names.join(', ')
  end
end
