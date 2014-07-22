require './dino_dex'

# Start of testing this stuff out (the implementation is a bit rough..)

# Skip validation of locale
I18n.enforce_available_locales = false

dex = DinoDex.new('dinodex.csv','african_dinosaur_export.csv')


dex.filter().print()

# dex.filter().export_json()

# dex.filter().where(:walking, "Biped")
# 	.print()


# dex.filter().where(:walking, "Biped")
#   .where_in(:diet, "Carnivore", "Insectivore", "Piscivore")
#   .print()


# dex.filter().where(:walking, "Biped")
# 	.where(:diet, "Carnivore")
# 	.more_than(:weight, 2000)
# 	.print()


dex.filter().where(:walking, "Biped")
	.where(:diet, "Carnivore")
	.where_in(:diet, "Carnivore", "Insectivore", "Piscivore")
	.where_in(:period, "Late Cretaceous", "Early Cretaceous")
	.more_than(:weight, 2000)
	.print()
