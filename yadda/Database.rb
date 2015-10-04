require 'pg'
require 'connection_pool'

class Database
  RANDOM_ID_RETRY_DEPTH = 5
  RANDOM_ID_RETRY_SLEEP = 5

  def initialize(name = nil, multiplier = 1)
    @db_name = name || 'yadda'
    @pool_size = multiplier * 5
    open_pool_connection
  end

  def open_pool_connection
    @db = ConnectionPool.new(size: @pool_size, timeout: 5) do
      PG::Connection.open(dbname: @db_name)
    end
  end

  def close_pool_connection
    @db.shutdown(&:close)
  end

  def insert(table, data)
    data_keys = data.keys.join(',')
    dollar_variables = data.keys.each_index.map { |x| "$#{x + 1}" }.join(',')
    @db.with do |conn|
      conn.exec(
        "INSERT INTO #{table} (#{data_keys}) VALUES (#{dollar_variables});",
        data.values,
      )
    end
  end

  def random_id(table, depth = 0)
    @db.with do |conn|
      conn.exec("SELECT * FROM #{table} ORDER BY RANDOM() LIMIT 1").first['id']
    end
  rescue
    rescue_random_id_failure(table, depth)
  end

  private

  # Searching for a random id that doesn't exist yet.
  # Sleep for a bit to let the data populate then search again
  def rescue_random_id_failure(table, depth)
    if depth >= RANDOM_ID_RETRY_DEPTH
      error = "Could not find random index within #{depth} tries." \
              'Try increasing RANDOM_ID_RETRY_DEPTH or RANDOM_ID_RETRY_SLEEP'
      raise IndexError, error
    end
    sleep(RANDOM_ID_RETRY_SLEEP)
    random_id(table, depth + 1)
  end
end
