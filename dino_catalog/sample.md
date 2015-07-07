# Dino Catalog Sample Program

### Dependencies
```sh
require 'csv'
require 'rails'
require './dinodex'
```

### Required Input
```sh
# Array of Include Files (What you want to load data from)
files = ['african_dinosaur_export.csv', 'dinodex.csv']```

###Usage
```sh
# Generate DinoDex
dex = DinoDex.new_from_files(files)

#Grab an Array of All Dinosaurs in the DinoDex
dinos = dex.dinos

# Generate a new DinoDex with bipeds
bipeds = dex.bipeds
# Generate an Array of All Bipeds in the Biped Dex
bipeds_arr = bipeds.dinos

# Combine Filters
mixed = dex.filter(:big, :cretaceous)
# Print a DinoDex
puts mixed
```
