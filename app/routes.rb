require "#{File.dirname(__FILE__)}/../lib/routing"
require "#{File.dirname(__FILE__)}/../lib/version"
require_relative './sistema_fiubak'
require_relative './errores/error_api'
require_relative './errores/error_parseo'
require_relative './parseador'

class Routes
  include Routing

  on_message '/start' do |bot, message|
    bot.api.send_message(chat_id: message.chat.id, text: "Moscu te saluda, #{message.from.first_name}")
  end

  on_message_pattern %r{/registrar( (?<argumentos>.*)|$)} do |bot, message, args|
    datos_registro = Parseador.new.parsear_registro(args['argumentos'], message.chat.id)

    respuesta = SistemaFiubak.new.registrar(datos_registro)
    bot.api.send_message(chat_id: message.chat.id, text: "Bienvenido #{respuesta.nombre}")

  rescue ErrorApi => e
    bot.api.send_message(chat_id: message.chat.id, text: e.mensaje)
  rescue ErrorParseo
    bot.api.send_message(chat_id: message.chat.id, text: 'Error: El uso del comando es /registrar <nombre>,<email>')
  end

  on_message_pattern %r{/ingresar_auto( (?<argumentos>.*)|$)} do |bot, message, args|
    datos_auto = Parseador.new.parsear_ingresar_auto(args['argumentos'], message.chat.id)

    respuesta = SistemaFiubak.new.ingresar_auto(datos_auto)

    bot.api.send_message(chat_id: message.chat.id, text: "Auto con patente #{respuesta.patente} ingresado al sistema")
  rescue ErrorApi => e
    bot.api.send_message(chat_id: message.chat.id, text: e.mensaje)
  rescue ErrorParseo
    bot.api.send_message(chat_id: message.chat.id, text: 'Error: El uso del comando es /ingresar_auto <modelo>,<patente>,<kilometros>,<año>')
  end

  on_message '/version' do |bot, message|
    bot.api.send_message(chat_id: message.chat.id, text: Version.current)
  end

  default do |bot, message|
    bot.api.send_message(chat_id: message.chat.id, text: 'Uh? No te entiendo! Me repetis la pregunta?')
  end
end
