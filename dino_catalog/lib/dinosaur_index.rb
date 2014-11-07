module DinosaurIndex
  InvalidDataError = Class.new(StandardException)

  LARGE_SIZE_LBS = 4000

  CARNIVOROUS_DIETS = [:insectivore, :piscicvore, :carnivore].freeze
  NONCARNIVOROUS_DIETS = [:herbivore].freeze
  DIETS = [*CARNIVOROUS_DIETS, *NONCARNIVOROUS_DIETS].freeze

  def legal_diet?(diet)
    DIETS.include?(diet)
  end

  def carnivorous?
    CARNIVOROUS_DIETS.include?(diet)
  end

  TIME_PERIODS = [
    :jurassic,
    :albian,
    :cretaceous,
    :triassic,
    :permian,
    :oxfordian,
  ]

  def legal_time_period?(period)
    TIME_PERIODS.include?(period)
  end

  POSTURES = [:bipedal, :quadrupedal]

  def legal_posture?(posture)
    POSTURES.include?(posture)
  end
end

require "dinosaur_index/dinosaur.rb"
