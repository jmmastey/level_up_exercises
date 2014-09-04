#!/usr/bin/env ruby

require 'colorize'
require 'terminal-table'
require_relative 'dinodex.rb'

class App
  def main
    clear_screen
    welcome
    begin
      cmd = get_command
      send *cmd unless cmd.length == 0
    end until cmd[0] == "quit"
  end

  def help
    puts File.read("helptext.txt").cyan
  end

  def welcome
    puts ("*" * 80).yellow
    puts "DinoDex Interface".yellow
    puts ("*" * 80).yellow
    puts "Type 'help' for a list of available commands."
    puts
  end

  def quit
    puts "Thank you for using DinoDex.".yellow
    puts
  end

  private
  def clear_screen
    puts "\e[H\e[2J"
  end

  def method_missing (m, *args, &block)
    puts "Invalid command: #{m}".red
    puts
  end

  def get_command
    print ">> "
    cmd = gets.downcase.split
    puts
    cmd
  end
end

app = App.new
app.main
