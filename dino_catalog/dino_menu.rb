require_relative 'dino_dex.rb'
# This class is used to define a user input error for dino the menu
class DinoMenu
  FILTER_OPTIONS =
   {    bi: :find_biped,
        c:  :find_carnivore,
        b:  :find_big,
        s:  :find_small,
        l:  :find_late_cretaceous,
        ec: :find_early_cretaceous,
        j:  :find_jurassic,
        ab: :find_abrictosaurus,
        al: :find_albertosaurus,
        bic: [:find_biped, :find_carnivore],
        bib: [:find_biped, :find_big],
        cs:  [:find_carnivore, :find_small]
   }

  MENU_OPTIONS =  <<DINOPTIONS
     Enter your choice(s):
     BI - Display all bipeds
     C - Display all carnivores
     B - Display all big dinos
     S - Display all small dinos
     L - Display all dinos from Late Cretaceous
     EC - Display all dinos from Early Cretaceous
     J - Display all dinos from Jurassic
     AB -  Display ABRICTOSAURUS
     AL -  Display ALBERTOSAURUS
     BIC - Diplay Biped and Carnivore
     BIB - Display Biped and Big
     CS - Display Carnivore and Small
     Exit - quit program
DINOPTIONS

  CHAINED_OPTIONS = [:bic, :bib, :cs]

  def filter(user_input)
    begin
      @dinodex.send FILTER_OPTIONS[user_input]
    rescue TypeError
      puts 'Please only enter these options' + FILTER_OPTIONS.keys.to_s.upcase
    end
  end

  def call_methods(methods)
    methods.inject(self) do |_obj, method|
      @dinodex.send method
    end
  end

  def initialize(csv_file)
    @dinodex = DinoDex.new(csv_file)
  end

  def run
    loop do
      p MENU_OPTIONS
      user_input = $stdin.gets.chomp.downcase.to_sym
      break if user_input == :exit
      filter(user_input) unless CHAINED_OPTIONS.include? user_input
      call_methods(FILTER_OPTIONS[user_input]) if CHAINED_OPTIONS.include? user_input
    end
  end
end
