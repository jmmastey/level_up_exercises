class Dinosaur
  attr_reader :name, :period, :continent, :diet, :weight, :walking, :description
      
  def initialize(args={})
    @name        = args[:name]
    @period      = args[:period]
    @continent   = args[:continent]
    @diet        = args[:diet]
    @weight      = args[:weight].to_i
    @walking     = args[:walking]
    @description = args[:description]
  end

  def to_s
    "#{@name}, #{@period}, #{@continent}, #{@diet}, #{@weight}, #{@walking}"
  end

  def bigger?(lbs)
    @weight > 0 && @weight > lbs
  end 

  def smaller?(lbs)
    @weight > 0 && @weight < lbs
  end

  def carnivore?
    !herbivore?
  end

  def herbivore?
    @diet == "Herbivore"
  end

  def biped?
    @walking == "Biped"
  end

  def period?(per)
    !(@period  =~ Regexp.new(per)).nil?
  end

end

class Dinodex
  
  @dinos=[]
  
  def self.parse_file(filename)
    dinos = []
    File.readlines(filename).drop(1).each do |line|
      dinos << Dinosaur.new(convert_line(line.chomp))
    end
    dinos 
  end
  
  def self.convert_line(line)
    # convert line to canonical hash
    col_names = [:name, :period, :continent, :diet, :weight, :walking, :description]
    Hash[col_names.zip(line.split(",").map { |x| x==""? nil: x})]
  end


  def initialize(initial_dinos)
    @dinos = initial_dinos
  end

  def add_dinos(new_dinos)
    @dinos = @dinos + new_dinos
  end

  def dinos
    @dinos
  end
  
  def dino_filter(field, criteria=nil)
    method = field.to_s.gsub(/s$/, '?').to_sym
    if criteria
      new_dinos = @dinos.select {|d| d.send(method, criteria) }
    else
      new_dinos = @dinos.select {|d| d.send(method) }
    end
    Dinodex.new(new_dinos) 
  end
end
in
    case field
    when :biggers
      new_dinos = @dinos.select {|d| d.bigger?(criteria) }
    when :smallers
      new_dinos = @dinos.select {|d| d.smaller?(criteria) }      
    when :bipeds
      new_dinos = @dinos.select {|d| d.biped? }
    when :carnivores
      new_dinos = @dinos.select {|d| d.carnivore? }
    when :periods
      new_dinos = @dinos.select {|d| d.period?(criteria)}   
    else
      raise "invalid dino-filter"
    end
  Dinodex.new(new_dinos) 
  end
=end
end

