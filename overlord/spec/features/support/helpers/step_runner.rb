class StepRunner

  def initialize(world, code, file, line_number)
    @world = world
    @code = code
    @file = file
    @line_number = line_number
  end

  def run
    split_lines
    group = []
    @lines.each do |line|
      if new_group?(line)
        execute_group(group)
        group = []
      end

      group << line
      @line_number += 1
    end
    execute_group(group) # the last group
  end

  private

  def new_group?(line)
    line =~ /^\s*(Given|When|Then|And) /
  end

  def execute_group(group)
    if valid_group?(group)
      code = group.join("\n") + "\n"
      begin
        @world.steps(code)
      rescue Exception => e
        inject_location(e)
        raise e
      end
    end
  end

  def inject_location(e)
    e.backtrace.unshift("#{@file}:#{@line_number}:in many_steps")
  end

  def valid_group?(group)
    group.collect(&:strip).any?(&:present?)
  end

  def split_lines
    @lines = @code.split(/\n/).collect(&method(:remove_comments))
    @line_number -= (@lines.length + 1)
  end

  def remove_comments(line)
    # Cucumber's `steps` cannot parse comments
    line.sub(/^\s*#.*$/, '')
  end

  module Harness

    def many_steps(code, file = nil, line_number = nil)
      if file.nil?
        pos = caller(1)[0]
        pos =~ /^([^:]+)\:(\d+)/
        file = $1
        line_number = $2.to_i if $2
      end
      if file.nil? || line_number.nil?
        raise "Could not detect file and line number. Fix me or call with __FILE__ and __LINE__ arguments."
      end
      StepRunner.new(self, code, file, line_number).run
    end

  end

end

World(StepRunner::Harness)
