module DasLogic

	def select(list, column_name, value)
		list.select{ |dino| dino[column_name] == value}
	end

	def search(args)
		list = @table
		args.each do |arg|
			search = arg.split(":")
			list = select(list, search[0], search[1])
		end
		return list
	end

end