require 'telegram/bot'
require File.dirname(__FILE__) + '/../app/routes'
require 'semantic_logger'

class BotClient
  def initialize(logger, token = ENV['TELEGRAM_TOKEN'])
    @token = token
    @logger = logger
  end

  def start
    @logger.info "Starting bot version:#{Version.current}"
    @logger.info "token is #{@token}"
    run_client do |bot|
      bot.listen { |message| handle_message(message, bot) }
    rescue StandardError => e
      @logger.fatal e.message
    end
  end

  def run_once
    run_client do |bot|
      bot.fetch_updates { |message| handle_message(message, bot) }
    end
  end

  private

  def run_client(&block)
    Telegram::Bot::Client.run(@token, logger: @logger) { |bot| block.call bot }
  end

  def handle_message(message, bot)
    @logger.info "From: #{message.from.username || message.from.first_name}, id: #{message.chat.id}, message: #{message.text}"

    Routes.new(@logger).handle(bot, message)
  rescue StandardError => e
    @logger.fatal e.message
  end
end
