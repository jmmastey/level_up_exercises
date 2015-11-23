require 'stargate'

module HbaseService
  TABLE = "dinodex"
  CF = "cf"
  QUAL = "data"
  URL = "http://localhost:8777"

  attr_accessor :hbase_client

  def self.init
    @hbase_client ||= Stargate::Client.new(URL, proxy: URL)
  end

  def self.put(key, data)
    raise "You must provide key and data" if key.nil? || data.nil?
    client = init
    client.create_row(TABLE, key, Time.now.to_i, name: "#{CF}:#{QUAL}", value: Marshal.dump(data))
  end

  def self.get(key)
    client = init
    row = client.show_row(TABLE, key)
    value = row.columns[0].value
    Marshal.load(value)
  end

  def self.delete(key)
    client = init
    client.delete_row(TABLE, key, nil, "#{CF}:#{QUAL}")
  end

  def self.scan_rowkeys
    results = []
    client = init
    scanner = client.open_scanner(TABLE, columns: ["#{CF}:#{QUAL}"])
    rows = client.get_rows(scanner)
    rows.each { |row| results << row.name }
    client.close_scanner(scanner)
    results
  end
end
