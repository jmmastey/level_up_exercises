require 'csv'

class CsvImporter
     def import(fname)
         csv=Array.new
         CSV.foreach(fname, :headers =>true, :header_converters => :symbol ) do |row|
             csv << row
         #puts row
         end
         #p csv[0][:name]
         #p csv[-1][:name]
         csv
     end
end
