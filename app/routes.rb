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

  on_message '/consultar_mis_autos' do |bot, message|
    respuesta = SistemaFiubak.new.consultar_mis_autos(message.chat.id)
    mensaje = ''

    # TODO: ver si cambiamos esto, se esta mandando un unico mensaje con todos los autos
    respuesta.each_with_index do |auto, index|
      mensaje += "##{1 + index} #{auto.patente}, #{auto.estado}" + (auto.esta_cotizado? ? ", #{auto.precio}" : '')
      mensaje += "\n" unless index == respuesta.size - 1
    end

    mensaje = 'No tenes autos registrados' if mensaje.empty?

    bot.api.send_message(chat_id: message.chat.id, text: mensaje)
  rescue ErrorApi => e
    bot.api.send_message(chat_id: message.chat.id, text: e.mensaje)
  end

  on_message '/listar_autos' do |bot, message|
    respuesta = SistemaFiubak.new.listar_autos
    mensaje = ''

    # TODO: ver si cambiamos esto, se esta mandando un unico mensaje con todos los autos
    respuesta.each_with_index do |auto, index|
      mensaje += "##{1 + index} #{auto.modelo}, #{auto.patente}, #{auto.kilometros}km, año #{auto.anio}, $#{auto.precio}, #{auto.es_fiubak ? 'Fiubak' : 'Particular'}"
      # TODO: revisar la parte de fiubak
      mensaje += "\n" unless index == respuesta.size - 1
    end

    mensaje = 'No hay autos a la venta' if mensaje.empty?

    bot.api.send_message(chat_id: message.chat.id, text: mensaje)
  rescue ErrorApi => e
    bot.api.send_message(chat_id: message.chat.id, text: e.mensaje)
  end

  on_message_pattern %r{/vender_a_fiubak( (?<argumentos>.*)|$)} do |bot, message, args|
    datos_auto = Parseador.new.parsear_compraventa_a_fiubak(args['argumentos'], message.chat.id)

    respuesta = SistemaFiubak.new.vender_a_fiubak(datos_auto)

    bot.api.send_message(chat_id: message.chat.id, text: "Se ha registrado la venta de tu vehiculo de patente #{respuesta.patente}")
  rescue ErrorApi => e
    bot.api.send_message(chat_id: message.chat.id, text: e.mensaje)
  rescue ErrorParseo
    bot.api.send_message(chat_id: message.chat.id, text: 'Error: El uso del comando es /vender_a_fiubak <patente>')
  end

  on_message_pattern %r{/publicar_p2p( (?<argumentos>.*)|$)} do |bot, message, args|
    datos_auto = Parseador.new.parsear_publicar_p2p(args['argumentos'], message.chat.id)

    respuesta = SistemaFiubak.new.publicar_p2p(datos_auto)

    bot.api.send_message(chat_id: message.chat.id, text: "Se ha publicado exitosamente tu vehiculo de patente #{respuesta.patente} a precio #{respuesta.precio}")
  rescue ErrorParseo
    bot.api.send_message(chat_id: message.chat.id, text: 'Error: El uso del comando es /publicar_p2p <patente>, <precio>')
  rescue ErrorApi => e
    bot.api.send_message(chat_id: message.chat.id, text: e.mensaje)
  end

  on_message_pattern %r{/comprar( (?<argumentos>.*)|$)} do |bot, message, args|
    datos_auto = Parseador.new.parsear_compraventa_a_fiubak(args['argumentos'], message.chat.id)

    respuesta = SistemaFiubak.new.publicar_p2p(datos_auto)
    # TODO: agregar manejo de errores
    bot.api.send_message(chat_id: message.chat.id, text: "Has comprado a fiubak el vehiculo de patente #{respuesta.patente} por un precio de #{respuesta.precio}")
  end

  on_message '/version' do |bot, message|
    bot.api.send_message(chat_id: message.chat.id, text: Version.current)
  end

  default do |bot, message|
    bot.api.send_message(chat_id: message.chat.id, text: 'Uh? No te entiendo! Me repetis la pregunta?')
  end
end
