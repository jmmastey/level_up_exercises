module DasLogic

	def select(list, columnName, value)
		list.select{ |dino| dino[columnName] == value}
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