# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ContactType.create({ name: 'Personal Email', type: 'email' })
ContactType.create({ name: 'Work Email', type: 'email' })
ContactType.create({ name: 'Cell Phone', type: 'phone' })
