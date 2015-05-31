require_relative('dino_menu.rb')

CSV_OPTIONS =
    {    dd: 'dinodex.csv',
         ad:  'african_dinosaur_export.csv'
    }

MENU_OPTIONS =  <<DINOPTIONS
     Enter your choice for csv to filter:
     DD - dinodex.csv
     AD - african_dinosaur_export.csv
     Exit - to exit
DINOPTIONS
p MENU_OPTIONS
loop do
  begin
    user_input = $stdin.gets.chomp.downcase
    dino =  DinoMenu.new(CSV_OPTIONS[user_input.to_sym])
    dino.run
    break
  rescue TypeError
    puts 'Please only enter these options' + CSV_OPTIONS.keys.to_s.upcase
    redo
  end
end
