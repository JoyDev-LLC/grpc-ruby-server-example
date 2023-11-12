# frozen_string_literal: true
require_relative 'config/application'


cli = Gruf::Cli::Executor.new
cli.run
