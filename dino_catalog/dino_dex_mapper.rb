class DinoDexMapper

  HEADER = ["NAME", "PERIOD", "CONTINENT","DIET", "WEIGHT_IN_LBS", 
      "WALKING", "DESCRIPTION"] 

  MAPPER = lambda {|data| Hash[
    :name => data["NAME"],
    :period => data["PERIOD"],
    :continent=> data["CONTINENT"],
    :diet => data["DIET"],
    :weight => data["WEIGHT_IN_LBS"],
    :walking => data["WALKING"],
    :description => data["DESCRIPTION"]]}
     
  def self. get_mapper
    {HEADER => MAPPER}
  end

end
