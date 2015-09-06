require_relative '../Database'

# Ensures a clean state for each test. Also ensures we work with a safe db.
RSpec.configure do |config|
  config.before(:suite) do
    db = PG.connect(dbname: 'postgres')
    db.exec('CREATE DATABASE test;')
    db.close
  end

  config.before(:each) do
    db = PG.connect(dbname: 'test')
    db.exec('DROP TABLE IF EXISTS users;')
    db.exec('CREATE TABLE users (id SERIAL PRIMARY KEY, name VARCHAR(50));')
    db.close
  end

  config.after(:suite) do
    db = PG.connect(dbname: 'postgres')
    db.exec('DROP DATABASE IF EXISTS test;')
    db.close
  end
end

describe 'Database' do
  let(:database) { Database.new('test') }

  describe '.insert' do
    it 'Inserts into the correct table' do
      db = PG.connect(dbname: 'test')
      database.insert('users', name: 'John')
      select_john = db.exec("SELECT * FROM users WHERE name = \'John\' LIMIT 1;")
      expect(select_john).to_not be_nil
      db.close
    end
  end

  describe '.random_id' do
    it 'returns 1 when there is only one entry in the database' do
      database.insert('users', name: 'John')
      expect(database.random_id('users').to_i).to eq(1)
    end
    it 'Gets the a random index from a table' do
      insert_names(database, %w(John Doe Smith))
      expect(database.random_id('users').to_i).to be_within(1).of(2)
    end
  end

  def insert_names(database, names)
    names.each do |name|
      database.insert('users', name: name)
    end
  end
end
