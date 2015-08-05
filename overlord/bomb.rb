class Bomb
	def initialize
		@state_table = {booted: false, activated: false, deactivated: false, exploded: false}
	  @a_code = nil
	  @d_code = nil
	end

	def booted(a_code = 1234, d_code = 0000)
		@a_code = a_code
		@d_code = d_code
		@state_table[:booted] = true
	end

	def activated
		@state_table[:activated] = true
	end

	def deactivate
		@state_table[:deactivate] = true
	end
end