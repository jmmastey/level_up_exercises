module DasLogic

	def select(list, column_name, value)
		list.select{ |dino| dino[column_name] == value}
	end

	def search(args)
		list = @table
		args.each do |k, v|
			list = select(list, k, v)
		end
		list
	end

end