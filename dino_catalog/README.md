## Dinosaur Catalog

It may not be immediately evident, but I am a huge fan of dinosaurs. They're huge and dangerous and have cool names like Giganotosaurus (not to be confused with Gigantosaurus).

...

Anyway. I need to catalog some dinosaurs for my newest project, DinoDex. I've got a [CSV](http://ruby-doc.org/stdlib-1.9.3/libdoc/csv/rdoc/CSV.html) file for the dinosaur facts, and I need the code to read all the dinosaur facts and do some basic manipulations with the data.

### Requirements

Go check out the CSVs and come back. Done? Cool, I've just got a few features I need:

1. I loaded my favorite dinosaurs into a CSV file you'll need to parse. I don't know a lot about African Dinosaurs though, so I downloaded one from The Pirate Bay. It isn't formatted as well as mine, so you'll need to handle both formats.
2. I have friends who ask me a lot of questions about dinosaurs (I'm kind of a big deal). Please make sure the dinodex is able to answer these things for me:
    * Grab all the dinosaurs that were bipeds.
    * Grab all the dinosaurs that were carnivores (fish and insects count).
    * Grab dinosaurs for specific periods (no need to differentiate between Early and Late Cretaceous, btw).
    * Grab only big (> 2 tons) or small dinosaurs.
    * Just to be sure, I'd love to be able to combine criteria at will, even better if I can chain filter calls together.
3. For a given dino, I'd like to be able to print all the known facts about that dinosaur. If there are facts missing, please don't print empty values, just skip that heading. Make sure to print Early / Late etc for the periods.
4. Also, I'll probably want to print all the dinosaurs in a given collection (after filtering, etc).

#### Extra Credit

1. I would love to have a way to do (and chain) generic search by parameters. I can pass in a hash, and I'd like to get the proper list of dinos back out.
2. CSV isn't may favorite format in the world. Can you implement a JSON export feature?

Happy Hunting. (Giganotosaurus was the largest hunting dinosaur, at 46 feet long and up to 8 tons! Suh-weet.)

## Dinodex Implementation ##

### Getting Started ###

- Run `bundle install`

### Examples: ###

- This will read the csv entry and output it in JSON format:
`thor dinodex:read_file ./dinodex.csv --to_json`

- This will filter loaded dinodex.csv for *Cretaceous periods:
`thor dinodex:read_file "./dinodex.csv" --criteria='period':'=~Cretaceous'`

- This will merge two loaded files given the column mapping as the last argument and write to a file named 'results.csv':
`thor dinodex:merge_files "./dinodex.csv" "./african_dinosaur_export.csv" --mapping=name:genus weight_in_lbs:weight diet:carnivore | tee results.csv`

- This will merge both data files and filter for Bipeds and print the columns 'name', 'period', 'weight_in_lbs', 'diet':
`thor dinodex:merge_files "./dinodex.csv" "./african_dinosaur_export.csv" --mapping=name:genus weight_in_lbs:weight diet:carnivore > results.csv && thor dinodex:read_file results.csv --criteria='walking':'=Biped' --columns= name period weight_in_lbs diet`

- This will read results.csv from the file_system and filter for records Jurassic period:
`thor dinodex:read_file results.csv --criteria='period':'=Jurassic' 'weight_in_lbs':'>6000'`

- This will filter loaded dinodex.csv for name equal to 'Dracopelta' and only print out columns 'name', 'period', 'continent', 'diet', 'walking' and 'description':
`thor dinodex:read_file "./dinodex.csv" --criteria='name':'=Dracopelta' --columns='name' 'period' 'continent' 'diet' 'walking' 'description'`

- This will merge both data files and filter for Cretaceous periods :
`thor dinodex:merge_files "./dinodex.csv" "./african_dinosaur_export.csv" --mapping=name:genus weight_in_lbs:weight diet:carnivore > results.csv && thor dinodex:read_file results.csv --criteria='period':'=~Cretaceous'`

- This will merge both data files and filter for Jurassic periods OR weight greater than 6000:
`thor dinodex:merge_files "./dinodex.csv" "./african_dinosaur_export.csv" --mapping=name:genus weight_in_lbs:weight diet:carnivore > results.csv && thor dinodex:read_file results.csv --criteria='period':'=Jurassic' 'weight_in_lbs':'>6000'`

- This will merge both data files and filter for Jurassic periods AND weight greater than 2000:
`thor dinodex:merge_files "./dinodex.csv" "./african_dinosaur_export.csv" --mapping=name:genus weight_in_lbs:weight diet:carnivore > results.csv && thor dinodex:read_file results.csv --criteria='period':'=Jurassic' > jurassic.csv && thor dinodex:read_file jurassic.csv --criteria='weight_in_lbs':'>2000'`