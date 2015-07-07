Running the application:

    ./dinodex.rb

This puts you into a "special" CLI, with the prompt *DinoDex $*.

You can list all information in the database (from the CSV files):

    DinoDex $ list

You can get details on a given dinosaur from the table, by:

    DinoDex $ details

The table that appears is interactive and will let you select one dinosaur, a range of dinosaurs, or all dinosaurs.

You can get into a query mode of the interface. Just type:

    DinoDex $ query

This will change your prompt to: *DinoDex <Query Mode> $*.

Now I can talk about some of the requirements and how my implementation attempts to satisfy them.

*Grab all the dinosaurs that were bipeds.*

    DinoDex <Query Mode> $ movement=Biped

    DinoDex <Query Mode> $ "Biped"

*Grab all the dinosaurs that were carnivores (fish and insects count).*

    DinoDex <Query Mode> $ diet=Carnivore

    DinoDex <Query Mode> $ "Carnivore"

*Grab dinosaurs for specific periods (no need to differentiate between Early and Late Cretaceous, btw).*

    DinoDex <Query Mode> $ period=Jurassic

    DinoDex <Query Mode> $ "Jurassic"

*Grab only big (> 2 tons) or small dinosaurs.*

    DinoDex <Query Mode> $ big

    DinoDex <Query Mode> $ small

*Just to be sure, I'd love to be able to combine criteria at will, even better if I can chain filter calls together.*

    DinoDex <Query Mode> $ period=Jurassic,"Carnivore"

    DinoDex <Query Mode> $ "Jurassic", "Carnivore"

    DinoDex <Query Mode> $ "Europe",big,"Biped"

*For a given dino, I'd like to be able to print all the known facts about that dinosaur. If there are facts missing, please don't print empty values, just skip that heading. Make sure to print Early / Late etc for the periods.*

Due to how I've implemented the table interface, this requirement would no longer make sense. The table will list all facts and seeing that a given fact is empty is something you want to see.

*Also, I'll probably want to print all the dinosaurs in a given collection (after filtering, etc).*

This happens automatically. A new table is generated for each filter criteria and displayed for you.
