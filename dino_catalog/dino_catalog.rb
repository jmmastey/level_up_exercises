class DinoCatalog
  attr_accessor :dinosaurs

  def initialize(dinosaurs = [])
    @dinosaurs = dinosaurs.clone
  end

  def filter(key, value)
    if key.to_s == "weight" && value.include?("<")
      dinosaurs.select! { |dinosaur| dinosaur.smaller_than?(value.to_s[1, value.length]) }
    elsif key.to_s == "weight" && value.include?(">")
      dinosaurs.select! { |dinosaur| dinosaur.larger_than?(value.to_s[1, value.length]) }
    else
      dinosaurs.select! { |dinosaur| dinosaur.instance_variable_get(("@#{key}")).to_s.downcase.include?(value.downcase) }
    end
    self
  end

  def print_data(requested_data)
    requested_data = Array(requested_data)
    dinosaurs.each do |dinosaur|
      dino_data ||= ''
      requested_data.each do |header_name|
        dino_data << "#{dinosaur.instance_variable_get(("@#{header_name}"))} | "
      end
      puts dino_data.slice(0..-4)
    end
  end
end
