# frozen_string_literal: true

require_relative 'config/application'

namespace :app do
  desc 'Run console '
  task :console do
    pry
  end
end

namespace :app do
  desc 'Start app'
  task :run do
    ruby 'main.rb'
  end
end

namespace :db do
  desc 'Create the database'
  task :create do
    ActiveRecord::Base.establish_connection(DbConfig.except('database'))
    ActiveRecord::Base.connection.create_database(DbConfig['database'])
    ActiveRecord::Base.clear_all_connections!
    puts 'Database created.'
  end

  desc 'Migrate the database'
  task :migrate do
    ActiveRecord::Base.establish_connection(DbConfig)
    ActiveRecord::MigrationContext.new('db/migrate/', ActiveRecord::SchemaMigration).migrate
    Rake::Task['db:schema'].invoke
    ActiveRecord::Base.clear_all_connections!
    puts 'Database migrated.'
  end

  desc 'Drop the database'
  task :drop do
    ActiveRecord::Base.establish_connection(DbConfig.except('database'))
    ActiveRecord::Base.connection.drop_database(DbConfig['database'])
    ActiveRecord::Base.clear_all_connections!
    puts 'Database deleted.'
  end

  desc 'Rollback the last migration'
  task :rollback do
    step = ENV['STEP'] ? ENV['STEP'].to_i : 1

    ActiveRecord::Base.connection.migration_context.rollback(step)

    Rake::Task['db:schema'].invoke
    puts 'Database rollback.'
  end

  desc 'Reset the database'
  task reset: %i[drop create migrate]

  desc 'Create a db/schema.rb file that is portable against any DB supported by AR'
  task :schema do
    ActiveRecord::Base.establish_connection(DbConfig)
    require 'active_record/schema_dumper'
    filename = 'db/schema.rb'
    File.open(filename, 'w:utf-8') do |file|
      ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
    end
  end

  desc 'Create seeds'
  task :seed do
    require_relative 'db/seeds'
  end
end

namespace :g do
  desc 'Generate migration'
  task :migration do
    name = ARGV[1] || raise('Specify name: rake g:migration your_migration')
    timestamp = Time.now.strftime('%Y%m%d%H%M%S')
    path = File.expand_path("../db/migrate/#{timestamp}_#{name}.rb", __FILE__)
    migration_class = name.split('_').map(&:capitalize).join

    File.open(path, 'w') do |file|
      file.write <<~EOF
        class #{migration_class} < ActiveRecord::Migration
          def self.up
          end
          def self.down
          end
        end
      EOF
    end

    puts "Migration #{path} created"
    abort # needed stop other tasks
  end
end
