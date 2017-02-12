module DinoDex
  require_relative 'common.rb'

  class Dinosaur
    include ::DinoDex::Common

    def initialize(params)
      params.each do |(key, value)|
        instance_variable_set("@#{key}", value)
        singleton_class.class_eval { attr_accessor key }
      end
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

    def target(condition)
      condition.try(:last) || condition
    end

    def operand(condition, value)
      default = value.try(:text?) ? :include? : :==
      condition.try(:first).try(:to_sym) || default
    end
  end
end
