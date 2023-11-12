# frozen_string_literal: true

require 'logger'

BotLogger = Logger.new('logs/logfile.log', 'monthly')
BotLogger.formatter = proc do |_severity, datetime, _progname, msg|
  date_format = datetime.strftime('%Y-%m-%d %H:%M:%S')
  "date=[#{date_format}] pid=##{Process.pid} message='#{msg}'\n"
end
