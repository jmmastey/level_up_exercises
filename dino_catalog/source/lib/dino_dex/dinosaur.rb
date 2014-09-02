module DinoDex
  require 'extlib'
  require 'pp'

  class Dinosaur
    attr_accessor :genus, :period, :continent, :diet, \
                  :weight, :locomotion_type, :description

    # TODO: GO FULL META - instance_variable_set("@#{key}", value)
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
      query = parse_criterion(criterion)
      return unless query[:value].respond_to?(query[:operand])
      query[:value].public_send(query[:operand], query[:target])
    end

    def to_s
      pp self
    end

    protected

    def parse_criterion(criterion)
      value = instance_variable_get("@#{criterion.first}")
      condition = criterion.last.try(:to_a).try(:flatten) || criterion.last
      {
        operand: operand(condition, condition),
        target: target(condition),
        value: value
      }
    end

    private

    def target(condition)
      condition.try(:last) || condition
    end

    def operand(condition, value)
      # value.respond_to?(:encoding): match_value.is_a?(String) || match_value.is_a?(Symbol)
      default = value.respond_to?(:encoding) ? :include? : :==
      condition.try(:first).try(:to_sym) || default
    end

  end
end
