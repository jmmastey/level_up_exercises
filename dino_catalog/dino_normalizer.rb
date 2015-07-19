class DinoNormalizer
  CARNIVORE_DIETS        = %w(Piscivore Insectivore Carnivore)
  MAX_SMALL_DINO_WEIGHT  = 4000

  def self.normalize(fields = {})
    normalize_field_aliases fields, :genus, [:name]
    normalize_field_aliases fields, :weight, [:weight_in_lbs]

    normalize_period fields
    normalize_carnivore fields
    normalize_size fields
  end

  def self.normalize_field_aliases(fields, field_name, aliases)
    aliases.each do |als|
      alias_val = fields.delete(als)
      unless alias_val.nil?
        fields[field_name] = alias_val
        break
      end
    end
  end

  def self.normalize_period(fields)
    period = fields[:period]
    return if period.nil?
    period_name = period.gsub(/late|early|\s/i, '')
    fields[:period_name] = period_name
  end

  def self.normalize_carnivore(fields)
    diet = fields[:diet]
    return if diet.nil?
    is_carnivore = CARNIVORE_DIETS.include?(diet) ? 'yes' : 'no'
    fields[:carnivore] = is_carnivore
  end

  def self.normalize_size(fields)
    weight = fields[:weight]
    return if weight.nil?
    size = weight > MAX_SMALL_DINO_WEIGHT ? 'big' : 'small'
    fields[:size] = size
  end
end
