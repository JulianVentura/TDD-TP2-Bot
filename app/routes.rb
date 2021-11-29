require "#{File.dirname(__FILE__)}/../lib/routing"
require "#{File.dirname(__FILE__)}/../lib/version"
require_relative './sistema_fiubak'

class Routes
  include Routing

  on_message '/start' do |bot, message|
    bot.api.send_message(chat_id: message.chat.id, text: "Moscu te saluda, #{message.from.first_name}")
  end

  on_message_pattern %r{/registrar( (?<argumentos>.*)|$)} do |bot, message, args|
    argumentos = args['argumentos'].split(',')

    nombre = argumentos[0]
    email = argumentos[1]

    respuesta = SistemaFiubak.new.registrar(nombre, email, message.chat.id)
    bot.api.send_message(chat_id: message.chat.id, text: "Bienvenido #{respuesta.nombre}")
  end

  on_message '/version' do |bot, message|
    bot.api.send_message(chat_id: message.chat.id, text: Version.current)
  end

  default do |bot, message|
    bot.api.send_message(chat_id: message.chat.id, text: 'Uh? No te entiendo! Me repetis la pregunta?')
  end
end
