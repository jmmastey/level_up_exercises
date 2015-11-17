##Dino Catalog Overview

This is a Dino Catalog gem. You can import Dinosaurs in CSV format, as well as filter Dinosaurs by different parameters once you've imported them.

##How To Use

First, require the gem in whichever necessary files, or in IRB if you wish to play around with it first.

```require 'dino_catalog'```

Create a new DinoImporter, which takes your csv file and turns each row of data into a Dinosaur object. If you are importing with normal Dinodex format, you don't need to pass a format type---but if you downloaded Dino Data from the Pirate Bay, then you should pass in the optional argument "pirate_bay" as shown in the example below

```
dinosaur_collection = DinoCatalog::DinoImporter.new

dinosaur_collection.import_from_csv('yourfile.csv') #Importing from a csv in normal Dinodex format

dinosaur_collection.import_from_csv('piratebayfile.csv', "pirate_bay") #Importing from a csv of dino data downloaded from the Pirate Bay
```

Then, load the collection of Dinosaur objects that you've created into a new Dinodex. Use the dinosaur_list method to access the collection of Dinosaurs now held inside the DinoImporter you made.

```dinodex = DinoCatalog::Dinodex.new(dinosaur_collection.dinosaur_list)```

##Dinodex methods

You can use the Dinodex to filter by various parameters using the method 'filter_by_attribute'.

```
dinodex.filter_by_attribute("walking", "biped") #=> collection of Dinosaurs with attribute walking equal to 'biped'

dinodex.filter_by_attribute("diet", "carnivore") #=> collection of Dinosaurs that eat fish, insects, and meat

dinodex.filter_by_attribute("period", "Early Cretaceous") #=> collection of Dinosaurs that lived in the Early Cretaceous period.

dinodex.filter_by_attribute("size", "big") #=> collection of Dinosaurs weighing over 2000 lbs.

dinodex.filter_by_attribute("size", "small") #=> collection of Dinosaurs weighing under 2000 lbs.

```

You can also chain filter calls together. For instance,

```
dinodex.filter_by_attribute("size","small").filter_by_attribute("diet", "carnivore") #=> collection of Dinosaurs that weigh less than 2000 lbs AND are also carnivores.
```

To print data about a collection of dinosaurs (whether all the 'saurs in your Dinodex, or just some that have been filtered):
```
quadrupeds = dinodex.filter_by_attribute("walking","quadruped")
dinodex.print_collection(quadrupeds) #prints a formatted list of quadruped Dinosaurs.
```

To export your dinosaur data as JSON:
```
small_dinos = dinodex.filter_by_attribute("size","big")
JsonMaker.export_json(small_dinos)
```

##Dinosaur methods

You can also print the facts about a given Dinosaur. Let's say that we filter a number of dinosaurs by size using the Dinodex we instantiated earlier.

```
dinosaur = dinodex.filter_by_attribute("size","small").first #=> first Dinosaur in the returned collection

dinosaur.print_facts #=> returns the Dinosaur object and prints its attributes, each on new lines.
```

