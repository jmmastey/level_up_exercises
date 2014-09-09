require "./dino"
require "./dinocommand"

require "csv"

class DinoParser
  CSVOPTS = {
    headers: true,
    header_converters: :downcase,
    converters: :integer
  }
  def parse(data)
    data = CSV.read(data, CSVOPTS)
    data.map do |row|
      Dinosaur.new(parse_csv_row(row.to_hash))
    end
  end

  private

  def parse_csv_row(csv_row)
    {
      name: csv_row["name"],
      period: csv_row["period"],
      continent: csv_row["continent"],
      diet: csv_row["diet"],
      walk: csv_row["walking"],
      weight: (csv_row["weight_in_lbs"] || -1),
      desc: csv_row["description"] || ""
    }
  end
end

class AfroDinoParser < DinoParser
  private

  def parse_csv_row(csv_row)
    diet = parse_carnivore(csv_row["carnivore"])
    weight = csv_row["weight"] || -1
    {
      name: csv_row["genus"],
      period: csv_row["period"],
      continent: "Africa",
      diet: diet,
      walk: csv_row["walking"],
      weight: weight,
      desc: ""
    }
  end

  def parse_carnivore(carnivore_value)
    carnivore_value == "Yes" ? "Carnivore" : "Herbivore"
  end
end

class DinoCommandParser
  COMMANDCLASSES = [AndCommand, SortCommand]

  def parse(command_text)
    commands = command_text.split(/;\s*/)
    commands.map { |command| parse_command(command) }
  end

private

  def parse_command(command)
    arguments = command.split(/\s+/)
    parse_arguments(arguments)
  end

  def parse_arguments(arguments)
    COMMANDCLASSES.each do |command_class|
      return command_class.new(arguments) if command_class.accepts?(arguments)
    end
    raise "ParseError: There was no class the accepts #{arguments}"
  end
end
