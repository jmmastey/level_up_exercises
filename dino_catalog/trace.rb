require 'colorize'

module Trace
  @@trace_enabled = false

  def self.on
    @@trace_enabled = true
    self.[] "Trace enabled."
  end

  def self.off
    self.[] "Trace disabled."
    @@trace_enabled = false
  end

  def self.trace_enabled?
    @@trace_enabled
  end

  def self.[] message
    if @@trace_enabled
      puts message.to_str.red
    end
  end
end
