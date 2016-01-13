require 'table_print'

module Display
  def self.print_all
    tp Catalog.dinosaurs
  end

  def self.print_one(result)
    puts "-------------------------"
    tp [result], name: { width: 100 }
    tp [result], period: { width: 100 }
    tp [result], continent: { width: 100 }
    tp [result], diet: { width: 100 }
    tp [result], weight_in_lbs: { width: 100 }
    tp [result], walking: { width: 100 }
    tp [result], description: { width: 100 }
  end
end
