require 'abanalyzer'
require_relative 'test.rb'

module DataScience
  class SplitTest < Test
    CONFIDENCE_LEVEL = 0.95

    def initialize(sample_data)
      super
      init_tester
    end

    def execute
      super
      begin
        @results = build_results
      rescue => ex
        return error_hash(ex)
      end
      self
    end

    protected

    def build_results
      {
        confidence_level: CONFIDENCE_LEVEL,
        groups: build_groups,
        p_value: p_value,
        score: score,
        status: :OK
      }
    end

    def build_groups
      @data.inject({}) do |a, (group, _)|
        a.merge!(group => build_group(group))
      end
    end

    def init_tester
      data = @data.inject({}) do |a, (k, v)|
        a.merge!(k => v.reject { |param, _| param == :total })
      end
      @tester = ABAnalyzer::ABTest.new(data)
    end

    def build_group(group)
      {
        conversion: conversion(group),
        confidence_interval: confidence_interval(group)
      }
    end

    def conversion(group)
      @data[group][:hits].to_f / @data[group][:total].to_f
    end

    def p_value
      @tester.chisquare_p
    end

    def score
      @tester.chisquare_score
    end

    def confidence_interval(group)
      args = [@data[group][:hits], @data[group][:total], CONFIDENCE_LEVEL]
      ABAnalyzer.confidence_interval(*args)
    end

    private

    def error_hash(ex)
      # FIXME: Needs proper exception responses
      {
        status: :FAIL,
        error: ex
      }
    end
  end
end
