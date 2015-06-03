require_relative 'dino_dex'
# This class is used to define a menu for the dino application
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
     Chained Commands - Enter each command followed by a space Ex. B EC
     Exit - quit program
DINOPTIONS

  CHAINED_OPTIONS = [:bic, :bib, :cs]

  def initialize(dinos)
    @dinodex = DinoDex.new(dinos)
  end

  def filter(user_input)
    print_val(@dinodex.send FILTER_OPTIONS[user_input])
  rescue TypeError
    puts 'Please only enter these options' + FILTER_OPTIONS.keys.to_s.upcase
  end

  def chain_methods(methods)
    individual_method   =  methods.to_s.split(' ')
    result = @dinodex
    individual_method.each do |meth|
      meth_sym = meth.to_sym
      result = result.send(FILTER_OPTIONS[meth_sym])
    end
    puts result.inspect
  rescue TypeError
    puts 'Please only enter these options' + FILTER_OPTIONS.keys.to_s.upcase
  end

  def print_val(dino_object)
    puts dino_object.inspect
  end

  def run
    puts MENU_OPTIONS
    loop do
      user_input = gets.chomp.downcase.to_sym
      break if user_input == :exit
      filter(user_input) if user_input.length <= 2
      chain_methods(user_input) if user_input.length > 2
    end
  end
end
