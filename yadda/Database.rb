require 'pg'

class Database
  def initialize(name = nil)
    @db_name = name || 'yadda'
  end

  def insert(table, data)
    db = PG::Connection.open(dbname: @db_name)
    data_keys = data.keys.join(',')
    dollar_variables = data.keys.each_index.map { |x| "$#{x + 1}" }.join(',')
    db.exec(
      "INSERT INTO #{table} (#{data_keys}) VALUES (#{dollar_variables});",
      data.values,
    )
    db.close
  end

  def random_id(table)
    db = PG::Connection.open(dbname: @db_name)
    id = db.exec("SELECT * FROM #{table} ORDER BY RANDOM() LIMIT 1").first['id']
    db.close
    id
  end
end
