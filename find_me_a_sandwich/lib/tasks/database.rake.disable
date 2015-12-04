require 'active_record/connection_adapters/postgresql_adapter'

# Bypasses zeus slave connection issue
module ActiveRecord
  module ConnectionAdapters
    class PostgreSQLAdapter < AbstractAdapter
      def drop_database(name)
        raise "Nah, I won't drop the production database" if Rails.env.production?
        execute <<-SQL
          UPDATE pg_catalog.pg_database
          SET datallowconn=false WHERE datname='#{name}'
        SQL

        execute <<-SQL
          SELECT pg_terminate_backend(pg_stat_activity.pid)
          FROM pg_stat_activity
          WHERE pg_stat_activity.datname = '#{name}';
        SQL
        execute "DROP DATABASE IF EXISTS #{quote_table_name(name)}"
      end
    end
  end
end

def format_class_name(model_class)
  model_class.name
    .underscore
    .humanize(capitalize: false)
    .pluralize(model_class.count)
end

namespace :db do
  desc "Clears info retrieved from API"
  task clear_api_data: :environment do
    [MenuItem, Menu, Location, Merchant].each do |model_class|
      puts "Deleting #{model_class.count} #{format_class_name(model_class)}..."
      model_class.delete_all
    end

    puts "Done."
  end
end
