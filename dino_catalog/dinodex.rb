require "csv"
require_relative "formatter"
require_relative "dino"

class Dinodex
  attr_accessor :dinos

  def initialize(filepaths: nil, dinos: [])
    @dinos = dinos
    create_dinos_from(Array(filepaths))
  end

  def find(search)
    raise ArgumentError if search.size != 1

    attribute = search.keys.first
    target = search[attribute]

    matching_dinos = @dinos.select { |dino| dino.matches?(attribute, target) }

    Dinodex.new(dinos: matching_dinos)
  end

  def size
    @dinos.size
  end

  def to_s
    @dinos.map(&:to_s).join
  end

  private

  def create_dinos_from(filepaths)
    dino_hashes = filepaths.map { |path| dino_hashes_from(path) }.flatten
    @dinos += dino_hashes.map { |dino_hash| Dino.new(dino_hash) }
  end

  def dino_hashes_from(path)
    raw_data = read_file(path)
    raw_header = read_header(raw_data)

    formatter = FormatterFactory.formatter(raw_header)
    formatter.format(raw_data)
  end

  def read_header(raw_data)
    return "" if raw_data.nil? || raw_data.empty?
    raw_data.lines.first.chomp
  end

  def read_file(path)
    File.read(path)
  rescue Errno::ENOENT
    STDERR.puts "WARNING: File #{path} not found, skipping"
  end
end
