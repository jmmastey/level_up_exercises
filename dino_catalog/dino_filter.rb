module DinoFilterTools
	class DinoFilter
	UNKONWN_FILTER = "Invalid filter(s) entered.  Please try again."
    FILTER_COMBOS = [
      %w( fat small ),
      %w( carnivore herbivore ),
      %w( biped quadruped ),
      %w( joe pirate_bay ),
      %w( jurassic albian cretaceous triassic permian oxfordian ),
      %w( north_america south_america africa europe asia )
    ]
    FILTER_GROUPS = {
	:periods => %w( jurassic albian cretaceous triassic permian oxfordian ),
	:attributes => %w( fat small biped quadruped carnivore herbivore ),
	:collections => %w( joe pirate_bay ),
	:continents => %w( north_america south_america africa europe asia )
	}

	def initialize
		puts "ok"
	end

	def goo
		puts FILTER_GROUPS
	end

	def filter_dinos(dinos, filters)

	end

	def valid_filters?(filters)
		FILTER_COMBOS.detect { |filter_group| (filter_group & filters).length > 1 }

	end

	def process_filter(dinos, filter)
    case
      when PERIODS.include?(filter) then period_filter(dinos, filter)
      when ATTRIBUTES.include?(filter) then attribute_filter(dinos, filter)
      when COLLECTIONS.include?(filter) then collection_filter(dinos, filter)
      when CONTINENTS.include?(filter) then continent_filter(dinos, filter)
    end

  end

  def attribute_filter(dinos, filter)
    dinos.select { |dino| dino.send("#{filter}?") }
  end

  def period_filter(dinos, filter)
    dinos.select { |dino| dino.period.include? filter }
  end

  def continent_filter(dinos, filter)
    dinos.select { |dino| dino.continent.include? filter.tr('_', ' ') }
  end

  def collection_filter(dinos, filter)
    if filter == "pirate_bay" then continent_filter(dinos, "africa")
    else dinos.select { |dino| dino.continent != "africa" }
    end
  end
  end
end

a = DinoFilterTools::DinoFilter.new
a.goo