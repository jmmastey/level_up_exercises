module DinoDex
  require 'extlib'
  require 'pp'

  class Dinosaur
    attr_accessor :genus, :period, :continent, :diet, \
                  :weight, :locomotion_type, :description

    def initialize(genus: nil, period: nil, continent: nil, diet: nil, weight: nil, locomotion_type: nil, description: nil)
      @genus = genus
      @period = period
      @continent = continent
      @diet = diet
      @weight = weight
      @locomotion_type = locomotion_type
      @description = description
    end

    def matches_all?(criteria = {})
      criteria.map(&method(:matches?)).all?
    end

    # Supported Grammar:
    # - { :variable => :equals_this }
    # - { :variable => { :< => :less_than_this } }
    # - { :variable => [ '>=', :greater_than_or_equal_to_this ] }
    def matches?(criterion)
      p = parse_criterion(criterion)
      return unless p[:value].respond_to?(p[:operand])
      p[:value].public_send(p[:operand], p[:target])
    end

    def to_s
      pp self
    end

    protected

    # Supported Criterion:
    # - [ :variable, :equals_this ]
    # - [ :variable, { :< => :less_than_this } ]
    # - [ :variable, [ '>=', :greater_than_or_equal_to_this ] ]
    def parse_criterion(criterion)
      match_variable = criterion.first.to_sym
      match_value = instance_variable_get("@#{match_variable}")
      is_text = match_value.is_a?(String) || match_value.is_a?(Symbol)
      match_condition = criterion.last.try(:to_a).try(:flatten) || criterion.last
      default_operand = is_text ? :include? : :==
      {
        operand: match_condition.try(:first).try(:to_sym) || default_operand,
        target: match_condition.try(:last) || match_condition,
        value: match_value
      }
    end
  end
end
