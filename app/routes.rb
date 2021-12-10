require "#{File.dirname(__FILE__)}/../lib/routing"
require "#{File.dirname(__FILE__)}/../lib/version"
require_relative './sistema_fiubak'
require_relative './errores/error_api'
require_relative './errores/error_parseo'
require_relative './parseador'
require_relative './impresora'

class Routes # rubocop:disable Metrics/ClassLength
  include Routing

  def initialize(logger)
    @@logger = logger # rubocop:disable Style/ClassVars
  end

  on_message '/start' do |bot, message|
    bot.api.send_message(chat_id: message.chat.id, text: 'Bienvenido a Fiubak. Usa /ayuda para más información')
  end

  on_message_pattern %r{/registrar( (?<argumentos>.*)|$)} do |bot, message, args|
    datos_registro = Parseador.new.parsear_registro(args['argumentos'], message.chat.id)

    respuesta = SistemaFiubak.new.registrar(datos_registro)
    bot.api.send_message(chat_id: message.chat.id, text: "Bienvenido #{respuesta.nombre}")

  rescue ErrorApi => e
    @@logger.error "[/registrar] Hubo un error: '#{e.mensaje}'"
    bot.api.send_message(chat_id: message.chat.id, text: e.mensaje)
  rescue ErrorParseo
    bot.api.send_message(chat_id: message.chat.id, text: 'Error: El uso del comando es /registrar <nombre>,<email>')
  end

  on_message_pattern %r{/ingresar_auto( (?<argumentos>.*)|$)} do |bot, message, args|
    datos_auto = Parseador.new.parsear_ingresar_auto(args['argumentos'], message.chat.id)

    respuesta = SistemaFiubak.new.ingresar_auto(datos_auto)

    bot.api.send_message(chat_id: message.chat.id, text: "Auto con patente #{respuesta.patente} ingresado al sistema")
  rescue ErrorApi => e
    @@logger.error "[/ingresar_auto] Hubo un error: '#{e.mensaje}'"
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
    @@logger.error "[/consultar_mis_autos] Hubo un error: '#{e.mensaje}'"
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
    @@logger.error "[/listar_autos] Hubo un error: '#{e.mensaje}'"
    bot.api.send_message(chat_id: message.chat.id, text: e.mensaje)
  end

  on_message_pattern %r{/vender_a_fiubak( (?<argumentos>.*)|$)} do |bot, message, args|
    datos_auto = Parseador.new.parsear_compraventa_a_fiubak(args['argumentos'], message.chat.id)

    respuesta = SistemaFiubak.new.vender_a_fiubak(datos_auto)

    bot.api.send_message(chat_id: message.chat.id, text: "Se ha registrado la venta de tu vehiculo de patente #{respuesta.patente}")
  rescue ErrorApi => e
    @@logger.error "[/vender_a_fiubak] Hubo un error: '#{e.mensaje}'"
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
    @@logger.error "[/publicar_p2p] Hubo un error: '#{e.mensaje}'"
    bot.api.send_message(chat_id: message.chat.id, text: e.mensaje)
  end

  on_message_pattern %r{/comprar( (?<argumentos>.*)|$)} do |bot, message, args|
    datos_compra = Parseador.new.parsear_compraventa_a_fiubak(args['argumentos'], message.chat.id)

    respuesta = SistemaFiubak.new.comprar(datos_compra)
    # TODO: agregar manejo de errores
    bot.api.send_message(chat_id: message.chat.id, text: "Has comprado a fiubak el auto de patente #{respuesta.patente} por un precio de #{respuesta.precio}")
  rescue ErrorParseo
    bot.api.send_message(chat_id: message.chat.id, text: 'Error: El uso del comando es /comprar <patente>')
  rescue ErrorApi => e
    @@logger.error "[/comprar] Hubo un error: '#{e.mensaje}'"
    bot.api.send_message(chat_id: message.chat.id, text: e.mensaje)
  end

  on_message_pattern %r{/realizar_oferta( (?<argumentos>.*)|$)} do |bot, message, args|
    datos_oferta = Parseador.new.parsear_realizar_oferta(args['argumentos'], message.chat.id)

    respuesta = SistemaFiubak.new.realizar_oferta(datos_oferta)

    bot.api.send_message(chat_id: message.chat.id,
                         text: "Has realizado con exito la oferta numero #{respuesta.id_oferta} al auto de patente #{respuesta.patente} con un precio de #{respuesta.precio}")
  rescue ErrorParseo
    bot.api.send_message(chat_id: message.chat.id, text: 'Error: El uso del comando es /realizar_oferta <patente>, <precio_oferta>')
  rescue ErrorApi => e
    @@logger.error "[/realizar_oferta] Hubo un error: '#{e.mensaje}'"
    bot.api.send_message(chat_id: message.chat.id, text: e.mensaje)
  end

  on_message_pattern %r{/rechazar_oferta( (?<argumentos>.*)|$)} do |bot, message, args|
    datos_oferta_elegida = Parseador.new.parsear_oferta_elegida(args['argumentos'], message.chat.id)

    respuesta = SistemaFiubak.new.rechazar_oferta(datos_oferta_elegida)

    bot.api.send_message(chat_id: message.chat.id,
                         text: "Has rechazado la oferta #{respuesta.id_oferta}")
  rescue ErrorParseo
    bot.api.send_message(chat_id: message.chat.id, text: 'Error: El uso del comando es /rechazar_oferta <ID_oferta>')
  rescue ErrorApi => e
    @@logger.error "[/rechazar_oferta] Hubo un error: '#{e.mensaje}'"
    bot.api.send_message(chat_id: message.chat.id, text: e.mensaje)
  end

  on_message_pattern %r{/consultar_ofertas_recibidas( (?<argumentos>.*)|$)} do |bot, message, args|
    datos_oferta = Parseador.new.parsear_consultar_ofertas_recibidas(args['argumentos'], message.chat.id)
    respuesta = SistemaFiubak.new.consultar_ofertas_recibidas(datos_oferta)
    mensaje = ''

    respuesta.each_with_index do |oferta, index|
      mensaje += "##{oferta.id_oferta} #{oferta.patente}, $#{oferta.precio}, #{oferta.estado}"
      # TODO: revisar la parte de fiubak
      mensaje += "\n" unless index == respuesta.size - 1
    end

    mensaje = "No se han recibido ofertas sobre el auto de patente #{datos_oferta.patente}" if mensaje.empty?

    bot.api.send_message(chat_id: message.chat.id, text: mensaje)
  rescue ErrorParseo
    bot.api.send_message(chat_id: message.chat.id, text: 'Error: El uso del comando es /consultar_ofertas_recibidas <patente>')
  rescue ErrorApi => e
    @@logger.error "[/consultar_ofertas_recibidas] Hubo un error: '#{e.mensaje}'"
    bot.api.send_message(chat_id: message.chat.id, text: e.mensaje)
  end

  on_message '/consultar_ofertas_realizadas' do |bot, message, _args|
    datos_oferta = Parseador.new.parsear_consultar_ofertas_realizadas(message.chat.id)
    respuesta = SistemaFiubak.new.consultar_ofertas_realizadas(datos_oferta)
    mensaje = ''

    respuesta.each_with_index do |oferta, index|
      mensaje += "##{oferta.id_oferta} #{oferta.patente}, $#{oferta.precio}, #{oferta.estado}"
      # TODO: revisar la parte de fiubak
      mensaje += "\n" unless index == respuesta.size - 1
    end

    mensaje = 'No se han realizado ofertas' if mensaje.empty?

    bot.api.send_message(chat_id: message.chat.id, text: mensaje)
  rescue ErrorApi => e
    @@logger.error "[/consultar_ofertas_realizadas] Hubo un error: '#{e.mensaje}'"
    bot.api.send_message(chat_id: message.chat.id, text: e.mensaje)
  end

  on_message_pattern %r{/aceptar_oferta( (?<argumentos>.*)|$)} do |bot, message, args|
    datos_oferta_elegida = Parseador.new.parsear_oferta_elegida(args['argumentos'], message.chat.id)

    respuesta = SistemaFiubak.new.aceptar_oferta(datos_oferta_elegida)

    bot.api.send_message(chat_id: message.chat.id,
                         text: "Has aceptado la oferta #{respuesta.id_oferta}")
  rescue ErrorParseo
    bot.api.send_message(chat_id: message.chat.id, text: 'Error: El uso del comando es /aceptar_oferta <id_oferta>')
  rescue ErrorApi => e
    @@logger.error "[/aceptar_oferta] Hubo un error: '#{e.mensaje}'"
    bot.api.send_message(chat_id: message.chat.id, text: e.mensaje)
  end

  on_message '/version' do |bot, message|
    bot.api.send_message(chat_id: message.chat.id, text: Version.current)
  end

  on_message '/ayuda' do |bot, message|
    bot.api.send_message(chat_id: message.chat.id, text: Impresora.new.ayuda)
  end

  default do |bot, message|
    bot.api.send_message(chat_id: message.chat.id, text: 'Comando inválido. Usa /ayuda para más información')
  end
end
