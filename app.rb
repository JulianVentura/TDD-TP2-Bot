require 'dotenv/load'
require './app/app_logger'
require File.dirname(__FILE__) + '/app/bot_client'

$stdout.sync = true

BotClient.new(AppLogger.new).start
