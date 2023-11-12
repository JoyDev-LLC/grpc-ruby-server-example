# frozen_string_literal: true

require 'dotenv'
require 'erb'
require 'yaml'
require 'active_record'
require 'pry'
require 'faker'
require_relative 'boot'
require_relative 'initializers/gruf'
Dotenv.load('.env')

Dir[File.join('./app', '**', '*.rb')].sort.each { |file| require file }

# Database connection
config = ERB.new(File.new('config/database.yml.erb').read)
DbConfig = YAML.safe_load(config.result(binding))
ActiveRecord::Base.establish_connection(DbConfig)