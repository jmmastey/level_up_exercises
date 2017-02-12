##Dino Catalog Overview

This is a Dino Catalog gem. You can import Dinosaurs in CSV format, as well as filter Dinosaurs by different parameters once you've imported them.

##How To Use

First, require the gem in whichever necessary files, or in IRB if you wish to play around with it first.

```require 'dino_catalog'```

Create a new DinoImporter, which takes your csv file and turns each row of data into a Dinosaur object. If you are importing with normal Dinodex format, you don't need to pass a format type---but if you downloaded Dino Data from the Pirate Bay, then you should pass in the optional argument formatter:PirateBayFormatter as shown in the example below. The default importer used is DinodexFormatter, which is used to convert CSV files in the default Dinodex format.

```
dinos = DinoCatalog::DinoImporter.import_from_csv(file: 'path_to_csv_file.csv') #DinoImporter.import_from_csv returns an array of Dinosaurs.

# To use the Pirate Bay formatter
DinoCatalog::DinoImporter.import_from_csv(file: 'path_to_second_file.csv', formatter: DinoCatalog::PirateBayFormatter) 
#Importing from a csv of dino data downloaded from the Pirate Bay
```

Then, load the collection of Dinosaur objects that you've created into a new Dinodex. Use the dinosaur_list method to access the collection of Dinosaurs now held inside the DinoImporter you made.

```dinodex = DinoCatalog::Dinodex.new(dinos)```

##Dinodex methods

You can use the Dinodex to filter by various parameters using the method 'filter_by_attribute'.

```
dinodex.filter(attribute: "walking", value: "biped") 
#=> Dinodex containing Dinosaurs with attribute walking equal to 'biped'

dinodex.filter(attribute: "diet", value: "carnivore") 
#=> Dinodex containing Dinosaurs that eat fish, insects, and meat

dinodex.filter(attribute: "period", value: "Early Cretaceous") 
#=> Dinodex containing Dinosaurs that lived in the Early Cretaceous period.

dinodex.filter(attribute: "size", value: "big") 
#=> Dinodex containing Dinosaurs weighing over 4000 lbs.

dinodex.filter(attribute: "size", value: "small") 
#=> Dinodex containing Dinosaurs weighing under 4000 lbs.

```

You can also chain filter calls together. For instance,

```
small = dinodex.filter(attribute: "size", value: "small")
small.filter(attribute: "diet", value: "carnivore").dinosaurs
#=> collection of Dinosaurs that weigh less than 2000 lbs AND are also carnivores.
```

To print data about a collection of dinosaurs (whether all the 'saurs in your Dinodex, or just some that have been filtered):
```
quadrupeds = dinodex.filter(attribute: "walking",value: "quadruped")

quadrupeds.print_collection #prints a formatted list of quadruped Dinosaurs.
```

To export your dinosaur data as JSON:
```
small_dinos = dinodex.filter(attribute: "size", value: "big")
small_dinos.serialize_collection
```

##Dinosaur methods

You can also print the facts about a given Dinosaur. Let's say that we filter a number of dinosaurs by size using the Dinodex we instantiated earlier.

```
dinosaur = dinodex.filter(attribute: "size", value: "small").dinosaurs.first 
#=> first Dinosaur in the returned collection

#Assuming 'dinos' refers to a collection of imported Dinosaurs
dinosaur.print
#=> returns the dinosaur collection and prints its 
# attributes, each on new lines.
```

