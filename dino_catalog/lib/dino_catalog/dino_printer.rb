module DinoCatalog
	class DinoPrinter
		def self.print_collection(dinosaurs)
      dinosaurs.each do |dinosaur|
        puts dinosaur
        puts ""
      end
    end

    def self.print_dinosaur(dinosaur)
    	puts dinosaur
    end
  end
end
