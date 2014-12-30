module DinoFilterTools
	class DinoFilter
    FILTER_GROUPS = [
      %w( fat small ),
      %w( carnivore herbivore ),
      %w( biped quadruped ),
      %w( joe pirate_bay ),
      %w( jurassic albian cretaceous triassic permian oxfordian ),
      %w( north_america south_america africa europe asia )
    ]

	PERIODS = %w( jurassic albian cretaceous triassic permian oxfordian )
	ATTRIBUTES = %w( fat small biped quadruped carnivore herbivore )
	COLLECTIONS = %w( joe pirate_bay )
	CONTINENTS = %w( north_america south_america africa europe asia )

	def validate_filters
		FILTER_GROUPS.each do |filter_group|
		if (filter_group & filters).length > 1
        puts "Invalid filter chaining.  Enter \"help\" for more information."
      end
    end
	end
  
end