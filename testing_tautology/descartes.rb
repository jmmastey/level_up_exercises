class Descartes
	attr_accessor :state
	
	def initialize
		@state = false
	end
	
	def dead?
		@state == false
	end
	
	def alive?
		@state == true
	end
end
