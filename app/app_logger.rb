class AppLogger
  def initialize(log_level = ENV['LOG_LEVEL'] || 'error', log_url = ENV['LOG_URL'] || 'http://fake.url')
    SemanticLogger.default_level = log_level.to_sym
    SemanticLogger.add_appender(
      io: $stdout
    )
    SemanticLogger.add_appender(
      appender: :http,
      url: log_url
    )
    @logger = SemanticLogger['BotClient']
  end

  def info(mensaje)
    @logger.info mensaje
  end

  def error(mensaje)
    @logger.error mensaje
  end

  def fatal(mensaje)
    @logger.fatal mensaje
  end

  attr_reader :logger
end
