class DinoDex
  require 'json'

  FILTERS = {
    :period => %w(jurassic cretaceous triassic permian),
    :'period subdivision' =>  %w(oxfordian albian),
    :continent => %w(north\ america south\ america asia africa europe),
    :diet => %w(carnivore herbivore),
    :'diet subtype' => %w(piscivore insectivore),
    :walking => %w(biped quadruped),
  }

  attr_reader :all_dinosaurs

  def initialize(dino_list)
    @all_dinosaurs = dino_list
  end

  def find(params)
    matchable_params = params.reject { |_k, v| v =~ /\d/ }
    dino_sets = [find_match(matchable_params),
                 find_weight(params[:min], params[:max])]
    dino_sets.reject(&:empty?).reduce(:&) || []
  end

  def find_match(matchable_params)
    return [] if matchable_params.empty?
    all_dinosaurs.select do |dino|
      matchable_params.each do |k, v|
        break unless dino.send(k) =~ /#{v}/i
      end
    end
  end

  def find_weight(min, max)
    return [] if min.nil? && max.nil?
    min = (min &&= min.to_i) || 0
    max = (max &&= max.to_i) || Float::INFINITY
    all_dinosaurs.select do |dino|
      next if dino.weight.nil?
      dino.weight.between?(min, max)
    end
  end

  def export_json
    export = all_dinosaurs.reduce([]) { |export, dino| export << dino.to_h }
    File.open('dinosaur_export.json', 'w') do |file|
      file.write(JSON.pretty_generate(export))
    end
  end
end
