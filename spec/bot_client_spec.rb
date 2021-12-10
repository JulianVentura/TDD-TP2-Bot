require 'spec_helper'
require 'web_mock'
require 'endpoints_helper'
# Uncomment to use VCR
# require 'vcr_helper'

require "#{File.dirname(__FILE__)}/../app/bot_client"

CHAT_ID = 141_733_544

def when_i_send_text(token, message_text)
  body = { "ok": true, "result": [{ "update_id": 693_981_718,
                                    "message": { "message_id": 11,
                                                 "from": { "id": CHAT_ID, "is_bot": false, "first_name": 'Emilio', "last_name": 'Gutter', "username": 'egutter', "language_code": 'en' },
                                                 "chat": { "id": CHAT_ID, "first_name": 'Emilio', "last_name": 'Gutter', "username": 'egutter', "type": 'private' },
                                                 "date": 1_557_782_998, "text": message_text,
                                                 "entities": [{ "offset": 0, "length": 6, "type": 'bot_command' }] } }] }

  stub_request(:any, "https://api.telegram.org/bot#{token}/getUpdates")
    .to_return(body: body.to_json, status: 200, headers: { 'Content-Length' => 3 })
end

def when_i_send_keyboard_updates(token, message_text, inline_selection)
  body = {
    "ok": true, "result": [{
      "update_id": 866_033_907,
      "callback_query": { "id": '608740940475689651', "from": { "id": CHAT_ID, "is_bot": false, "first_name": 'Emilio', "last_name": 'Gutter', "username": 'egutter', "language_code": 'en' },
                          "message": {
                            "message_id": 626,
                            "from": { "id": 715_612_264, "is_bot": true, "first_name": 'fiuba-memo2-prueba', "username": 'fiuba_memo2_bot' },
                            "chat": { "id": CHAT_ID, "first_name": 'Emilio', "last_name": 'Gutter', "username": 'egutter', "type": 'private' },
                            "date": 1_595_282_006,
                            "text": message_text,
                            "reply_markup": {
                              "inline_keyboard": [
                                [{ "text": 'Jon Snow', "callback_data": '1' }],
                                [{ "text": 'Daenerys Targaryen', "callback_data": '2' }],
                                [{ "text": 'Ned Stark', "callback_data": '3' }]
                              ]
                            }
                          },
                          "chat_instance": '2671782303129352872',
                          "data": inline_selection }
    }]
  }

  stub_request(:any, "https://api.telegram.org/bot#{token}/getUpdates")
    .to_return(body: body.to_json, status: 200, headers: { 'Content-Length' => 3 })
end

def then_i_get_text(token, message_text)
  body = { "ok": true,
           "result": { "message_id": 12,
                       "from": { "id": 715_612_264, "is_bot": true, "first_name": 'fiuba-memo2-prueba', "username": 'fiuba_memo2_bot' },
                       "chat": { "id": CHAT_ID, "first_name": 'Emilio', "last_name": 'Gutter', "username": 'egutter', "type": 'private' },
                       "date": 1_557_782_999, "text": message_text } }

  stub_request(:post, "https://api.telegram.org/bot#{token}/sendMessage")
    .with(
      body: { 'chat_id' => '141733544', 'text' => message_text }
    )
    .to_return(status: 200, body: body.to_json, headers: {})
end

def then_i_get_keyboard_message(token, message_text)
  body = { "ok": true,
           "result": { "message_id": 12,
                       "from": { "id": 715_612_264, "is_bot": true, "first_name": 'fiuba-memo2-prueba', "username": 'fiuba_memo2_bot' },
                       "chat": { "id": CHAT_ID, "first_name": 'Emilio', "last_name": 'Gutter', "username": 'egutter', "type": 'private' },
                       "date": 1_557_782_999, "text": message_text } }

  stub_request(:post, "https://api.telegram.org/bot#{token}/sendMessage")
    .with(
      body: { 'chat_id' => '141733544',
              'reply_markup' => '{"inline_keyboard":[[{"text":"Jon Snow","callback_data":"1"}],[{"text":"Daenerys Targaryen","callback_data":"2"}],[{"text":"Ned Stark","callback_data":"3"}]]}',
              'text' => message_text }
    )
    .to_return(status: 200, body: body.to_json, headers: {})
end

describe 'BotClient' do
  it 'should get a /version message and respond with current version' do
    token = 'fake_token'

    when_i_send_text(token, '/version')
    then_i_get_text(token, Version.current)

    app = BotClient.new(token)

    app.run_once
  end

  it 'should get a /start message and respond with Moscu te saluda' do
    token = 'fake_token'

    when_i_send_text(token, '/start')
    then_i_get_text(token, 'Moscu te saluda, Emilio')

    app = BotClient.new(token)

    app.run_once
  end

  it 'debería recibir un mensaje /ayuda y responder con la lista de comandos validos' do
    token = 'fake_token'

    when_i_send_text(token, '/ayuda')
    then_i_get_text(token, Impresora.new.ayuda)

    app = BotClient.new(token)

    app.run_once
  end

  it 'deberia obtener un mensaje que no se interpretar y devolver un mensaje de ayuda' do
    token = 'fake_token'

    when_i_send_text(token, '/unknown')
    then_i_get_text(token, 'Comando inválido. Usa /ayuda para más información')

    app = BotClient.new(token)

    app.run_once
  end
  context 'when /registrar' do
    it 'deberia responder a "/registrar juan, juan@test.com" exitosamente' do
      token = 'fake_token'

      body = {
        nombre: 'juan',
        email: 'juan@mail.com',
        id: 123
      }

      MockeadorEndpoints.new.mockear_post(registrar_url, 201, body)

      when_i_send_text(token, '/registrar juan, juan@test.com')
      then_i_get_text(token, 'Bienvenido juan')

      app = BotClient.new(token)

      app.run_once
    end

    it 'deberia responder a "/registrar juan, juan@test.com" con error' do
      token = 'fake_token'

      mensaje_error = 'Error: Ya estas registrado'

      body = {
        error: mensaje_error
      }

      MockeadorEndpoints.new.mockear_post(registrar_url, 400, body)

      when_i_send_text(token, '/registrar juan, juan@test.com')
      then_i_get_text(token, mensaje_error)

      app = BotClient.new(token)

      app.run_once
    end

    it 'deberia responder a "/registrar juan" con mensaje de ayuda' do
      token = 'fake_token'

      mensaje_error = 'Error: El uso del comando es /registrar <nombre>,<email>'

      when_i_send_text(token, '/registrar juan')
      then_i_get_text(token, mensaje_error)

      app = BotClient.new(token)

      app.run_once
    end
  end

  context 'when /ingresar_auto' do
    it 'deberia responder a "/ingresar_auto Fiat Uno,ABC123,10000,1990" exitosamente' do
      token = 'fake_token'

      body = {
        patente: 'ABC123',
        modelo: 'Fiat Uno',
        kilometros: 10_000,
        anio: 1990,
        id_prop: 1234,
        estado: 'En revision'
      }

      MockeadorEndpoints.new.mockear_post(ingresar_auto_url, 201, body)

      when_i_send_text(token, '/ingresar_auto Fiat Uno,ABC123,10000,1990')
      then_i_get_text(token, 'Auto con patente ABC123 ingresado al sistema')

      app = BotClient.new(token)

      app.run_once
    end

    it 'deberia responder a "/ingresar_auto Fiat Uno,ABC123,10000,1990" con error' do
      token = 'fake_token'

      mensaje_error = 'Error: Auto ya registrado'

      body = {
        error: mensaje_error
      }

      MockeadorEndpoints.new.mockear_post(ingresar_auto_url, 400, body)

      when_i_send_text(token, '/ingresar_auto Fiat Uno,ABC123,10000,1990')
      then_i_get_text(token, mensaje_error)

      app = BotClient.new(token)

      app.run_once
    end

    it 'deberia responder a "/ingresar_auto Fiat Uno" con mensaje de ayuda' do
      token = 'fake_token'

      mensaje_error = 'Error: El uso del comando es /ingresar_auto <modelo>,<patente>,<kilometros>,<año>'

      when_i_send_text(token, '/ingresar_auto Fiat Uno')
      then_i_get_text(token, mensaje_error)

      app = BotClient.new(token)

      app.run_once
    end
  end

  context 'when /consultar_mis_autos' do
    let(:auto) do
      {
        patente: 'ABC123',
        modelo: 'Fiat Uno',
        kilometros: 10_000,
        anio: 1990,
        id_prop: 1234,
        estado: 'En revision'
      }
    end

    it 'deberia responder exitosamente' do
      token = 'fake_token'

      body = [auto]

      MockeadorEndpoints.new.mockear_get(consultar_mis_autos_url(CHAT_ID), 200, body)

      when_i_send_text(token, '/consultar_mis_autos')
      then_i_get_text(token, '#1 ABC123, En revision')

      app = BotClient.new(token)

      app.run_once
    end

    it 'deberia responder con un auto cotizado' do
      token = 'fake_token'

      auto1 = {
        patente: 'ABC123',
        modelo: 'Fiat Uno',
        kilometros: 10_000,
        anio: 1990,
        id_prop: 1234,
        estado: 'Cotizado',
        precio: 5000
      }

      body = [auto1]

      MockeadorEndpoints.new.mockear_get(consultar_mis_autos_url(CHAT_ID), 200, body)

      when_i_send_text(token, '/consultar_mis_autos')
      then_i_get_text(token, '#1 ABC123, Cotizado, 5000')

      app = BotClient.new(token)

      app.run_once
    end

    it 'deberia responder con varios autos' do
      token = 'fake_token'

      auto1 = {
        patente: 'AB123CD',
        modelo: 'Fiat Uno',
        kilometros: 10_000,
        anio: 1990,
        id_prop: 1234,
        estado: 'Cotizado',
        precio: 5000
      }

      body = [auto1, auto]

      MockeadorEndpoints.new.mockear_get(consultar_mis_autos_url(CHAT_ID), 200, body)

      when_i_send_text(token, '/consultar_mis_autos')
      then_i_get_text(token, "#1 AB123CD, Cotizado, 5000\n#2 ABC123, En revision")

      app = BotClient.new(token)

      app.run_once
    end

    it 'deberia responder con "No tenes autos registrados"' do
      token = 'fake_token'

      body = []

      MockeadorEndpoints.new.mockear_get(consultar_mis_autos_url(CHAT_ID), 200, body)

      when_i_send_text(token, '/consultar_mis_autos')
      then_i_get_text(token, 'No tenes autos registrados')

      app = BotClient.new(token)

      app.run_once
    end
  end

  context 'when /vender_a_fiubak' do
    it 'deberia responder exitosamente' do
      token = 'fake_token'

      body = {
        patente: 'ABC123',
        modelo: 'Fiat Uno',
        kilometros: 10_000,
        anio: 1990,
        id_prop: 1234,
        estado: 'Esperando entrega',
        precio: 15_000
      }

      MockeadorEndpoints.new.mockear_post(vender_a_fiubak_url('ABC123'), 200, body)

      when_i_send_text(token, '/vender_a_fiubak ABC123')
      then_i_get_text(token, 'Se ha registrado la venta de tu vehiculo de patente ABC123')

      app = BotClient.new(token)

      app.run_once
    end

    it 'deberia responder con error en caso de haber un error' do
      token = 'fake_token'

      body = {
        error: 'Hubo un error en la API'
      }

      MockeadorEndpoints.new.mockear_post(vender_a_fiubak_url('ABC123'), 400, body)

      when_i_send_text(token, '/vender_a_fiubak ABC123')
      then_i_get_text(token, 'Hubo un error en la API')

      app = BotClient.new(token)

      app.run_once
    end

    it 'deberia responder a "/vender_a_fiubak" con mensaje de ayuda' do
      token = 'fake_token'

      mensaje_error = 'Error: El uso del comando es /vender_a_fiubak <patente>'

      when_i_send_text(token, '/vender_a_fiubak')
      then_i_get_text(token, mensaje_error)

      app = BotClient.new(token)

      app.run_once
    end
  end

  context 'when /listar_autos' do
    it 'deberia responder exitosamente' do # rubocop:disable RSpec/ExampleLength
      token = 'fake_token'

      auto = {
        patente: 'ABC123',
        modelo: 'Fiat Uno',
        kilometros: 10_000,
        anio: 1990,
        id_prop: 1234,
        estado: 'Publicado',
        precio: 15_000,
        es_fiubak: true
      }

      body = [auto]

      MockeadorEndpoints.new.mockear_get(listar_autos_url, 200, body)

      when_i_send_text(token, '/listar_autos')
      then_i_get_text(token, '#1 Fiat Uno, ABC123, 10000km, año 1990, $15000, Fiubak')

      app = BotClient.new(token)

      app.run_once
    end

    it 'deberia responder con error en caso de haber un error' do
      token = 'fake_token'

      body = {
        error: 'Hubo un error en la API'
      }

      MockeadorEndpoints.new.mockear_get(listar_autos_url, 400, body)

      when_i_send_text(token, '/listar_autos')
      then_i_get_text(token, 'Hubo un error en la API')

      app = BotClient.new(token)

      app.run_once
    end
  end

  context 'when /publicar_p2p' do
    it 'deberia responder exitosamente' do
      token = 'fake_token'

      body = {
        patente: 'ABC123',
        modelo: 'Fiat Uno',
        kilometros: 10_000,
        anio: 1990,
        id_prop: 1234,
        estado: 'Publicado',
        precio: 30_000
      }

      MockeadorEndpoints.new.mockear_post(publicar_p2p_url('ABC123'), 200, body)

      when_i_send_text(token, '/publicar_p2p ABC123, 30000')
      then_i_get_text(token, 'Se ha publicado exitosamente tu vehiculo de patente ABC123 a precio 30000')

      app = BotClient.new(token)

      app.run_once
    end

    it 'deberia responder con error en caso de haber un error' do
      token = 'fake_token'

      body = {
        error: 'Hubo un error en la API'
      }

      MockeadorEndpoints.new.mockear_post(publicar_p2p_url('ABC123'), 400, body)

      when_i_send_text(token, '/publicar_p2p ABC123, 30000')
      then_i_get_text(token, 'Hubo un error en la API')

      app = BotClient.new(token)

      app.run_once
    end

    it 'deberia responder a "/publicar_p2p ABC123" con mensaje de ayuda' do
      token = 'fake_token'

      mensaje_error = 'Error: El uso del comando es /publicar_p2p <patente>, <precio>'

      when_i_send_text(token, '/publicar_p2p ABC123')
      then_i_get_text(token, mensaje_error)

      app = BotClient.new(token)

      app.run_once
    end
  end

  context 'when /comprar' do
    it 'deberia responder exitosamente' do
      token = 'fake_token'

      body = {
        patente: 'ABC123',
        modelo: 'Fiat Uno',
        kilometros: 10_000,
        anio: 1990,
        id_prop: 1234,
        estado: 'Vendido',
        precio: 30_000,
        es_fiubak: false
      }

      MockeadorEndpoints.new.mockear_post(comprar_a_fiubak_url('ABC123'), 200, body)

      when_i_send_text(token, '/comprar ABC123')
      then_i_get_text(token, 'Has comprado a fiubak el auto de patente ABC123 por un precio de 30000')

      app = BotClient.new(token)

      app.run_once
    end

    it 'deberia responder con error en caso de haber un error' do
      token = 'fake_token'

      body = {
        error: 'Hubo un error en la API'
      }

      MockeadorEndpoints.new.mockear_post(comprar_a_fiubak_url('ABC123'), 400, body)

      when_i_send_text(token, '/comprar ABC123')
      then_i_get_text(token, 'Hubo un error en la API')

      app = BotClient.new(token)

      app.run_once
    end

    it 'deberia responder a "/comprar" con mensaje de ayuda' do
      token = 'fake_token'

      mensaje_error = 'Error: El uso del comando es /comprar <patente>'

      when_i_send_text(token, '/comprar')
      then_i_get_text(token, mensaje_error)

      app = BotClient.new(token)

      app.run_once
    end
  end

  context 'when /realizar_oferta' do
    it 'deberia responder exitosamente' do
      token = 'fake_token'

      body = {
        id_oferta: 1,
        id_ofertante: 4567,
        patente: 'ABC123',
        precio: 30_000
      }

      MockeadorEndpoints.new.mockear_post(realizar_oferta_url('ABC123'), 200, body)

      when_i_send_text(token, '/realizar_oferta ABC123, 30000')
      then_i_get_text(token, 'Has realizado con exito la oferta numero 1 al auto de patente ABC123 con un precio de 30000')

      app = BotClient.new(token)

      app.run_once
    end

    it 'deberia responder con error en caso de haber un error' do
      token = 'fake_token'

      body = {
        error: 'Hubo un error en la API'
      }

      MockeadorEndpoints.new.mockear_post(realizar_oferta_url('ABC123'), 400, body)

      when_i_send_text(token, '/realizar_oferta ABC123, 30000')
      then_i_get_text(token, 'Hubo un error en la API')

      app = BotClient.new(token)

      app.run_once
    end

    it 'deberia responder a "/realizar_oferta ABC123" con mensaje de ayuda' do
      token = 'fake_token'

      mensaje_error = 'Error: El uso del comando es /realizar_oferta <patente>, <precio_oferta>'

      when_i_send_text(token, '/realizar_oferta ABC123')
      then_i_get_text(token, mensaje_error)

      app = BotClient.new(token)

      app.run_once
    end
  end

  context 'when /rechazar_oferta' do
    it 'deberia responder exitosamente' do
      token = 'fake_token'

      body = {
        id_oferta: 1,
        id_ofertante: 4567,
        patente: 'ABC123',
        precio: 30_000,
        estado: 'Rechazada'
      }

      MockeadorEndpoints.new.mockear_post(rechazar_oferta_url(1), 200, body)

      when_i_send_text(token, '/rechazar_oferta 1')
      then_i_get_text(token, 'Has rechazado la oferta 1')

      app = BotClient.new(token)

      app.run_once
    end

    it 'deberia responder con error en caso de haber un error' do
      token = 'fake_token'

      body = {
        error: 'Hubo un error en la API'
      }

      MockeadorEndpoints.new.mockear_post(rechazar_oferta_url(1), 400, body)

      when_i_send_text(token, '/rechazar_oferta 1')
      then_i_get_text(token, 'Hubo un error en la API')

      app = BotClient.new(token)

      app.run_once
    end

    it 'deberia responder a "/rechazar_oferta" con mensaje de ayuda' do
      token = 'fake_token'

      mensaje_error = 'Error: El uso del comando es /rechazar_oferta <ID_oferta>'

      when_i_send_text(token, '/rechazar_oferta')
      then_i_get_text(token, mensaje_error)
    end
  end

  context 'when /consultar_ofertas_recibidas' do
    let(:patente) { 'ABC123' }

    it 'deberia responder exitosamente' do
      token = 'fake_token'

      oferta = {
        id_oferta: 123,
        id_ofertante: 4567,
        patente: patente,
        precio: 50_000,
        estado: 'Rechazada'
      }
      params = { id_prop: CHAT_ID }
      body = [oferta]

      MockeadorEndpoints.new.mockear_get(consultar_ofertas_recibidas_url(patente), 200, body, params)

      when_i_send_text(token, '/consultar_ofertas_recibidas ABC123')
      then_i_get_text(token, '#123 ABC123, $50000, Rechazada')
      app = BotClient.new(token)

      app.run_once
    end

    it 'deberia responder con "No se han recibido ofertas"' do
      token = 'fake_token'

      params = { id_prop: CHAT_ID }
      body = []

      MockeadorEndpoints.new.mockear_get(consultar_ofertas_recibidas_url(patente), 200, body, params)

      when_i_send_text(token, '/consultar_ofertas_recibidas ABC123')
      then_i_get_text(token, "No se han recibido ofertas sobre el auto de patente #{patente}")
      app = BotClient.new(token)

      app.run_once
    end

    it 'deberia responder con error en caso de haber un error' do
      token = 'fake_token'

      params = { id_prop: CHAT_ID }

      body = {
        error: 'Hubo un error en la API'
      }

      MockeadorEndpoints.new.mockear_get(consultar_ofertas_recibidas_url(patente), 400, body, params)

      when_i_send_text(token, '/consultar_ofertas_recibidas ABC123')
      then_i_get_text(token, 'Hubo un error en la API')

      app = BotClient.new(token)

      app.run_once
    end

    it 'deberia responder con mensaje de ayuda' do
      token = 'fake_token'

      when_i_send_text(token, '/consultar_ofertas_recibidas')
      then_i_get_text(token, 'Error: El uso del comando es /consultar_ofertas_recibidas <patente>')

      app = BotClient.new(token)

      app.run_once
    end
  end

  context 'when /consultar_ofertas_realizadas' do
    let(:patente) { 'ABC123' }

    it 'deberia responder exitosamente' do
      token = 'fake_token'

      oferta = {
        id_oferta: 300,
        id_ofertante: 4567,
        patente: patente,
        precio: 50_000,
        estado: 'Rechazada'
      }
      body = [oferta]

      MockeadorEndpoints.new.mockear_get(consultar_ofertas_realizadas_url(CHAT_ID), 200, body)

      when_i_send_text(token, '/consultar_ofertas_realizadas')
      then_i_get_text(token, '#300 ABC123, $50000, Rechazada')
      app = BotClient.new(token)

      app.run_once
    end

    it 'deberia responder con error en caso de haber un error' do
      token = 'fake_token'

      body = {
        error: 'Hubo un error en la API'
      }

      MockeadorEndpoints.new.mockear_get(consultar_ofertas_realizadas_url(CHAT_ID), 400, body)

      when_i_send_text(token, '/consultar_ofertas_realizadas')
      then_i_get_text(token, 'Hubo un error en la API')

      app = BotClient.new(token)

      app.run_once
    end

    it 'deberia responder con "No se han realizado ofertas"' do
      token = 'fake_token'

      body = []

      MockeadorEndpoints.new.mockear_get(consultar_ofertas_realizadas_url(CHAT_ID), 200, body)

      when_i_send_text(token, '/consultar_ofertas_realizadas')
      then_i_get_text(token, 'No se han realizado ofertas')
      app = BotClient.new(token)

      app.run_once
    end
  end

  context 'when /aceptar_oferta' do
    let(:id_oferta) { 1 }

    it 'deberia responder exitosamente' do
      token = 'fake_token'

      body = {
        id_oferta: id_oferta,
        id_ofertante: 4567,
        patente: 'ABC123',
        precio: 30_000,
        estado: 'Aceptada'
      }

      MockeadorEndpoints.new.mockear_post(aceptar_oferta_url(id_oferta), 200, body)

      when_i_send_text(token, "/aceptar_oferta #{id_oferta}")
      then_i_get_text(token, "Has aceptado la oferta #{id_oferta}")

      app = BotClient.new(token)

      app.run_once
    end

    it 'deberia responder con error en caso de haber un error' do
      token = 'fake_token'

      body = {
        error: 'Hubo un error en la API'
      }

      MockeadorEndpoints.new.mockear_post(aceptar_oferta_url(id_oferta), 400, body)

      when_i_send_text(token, "/aceptar_oferta #{id_oferta}")
      then_i_get_text(token, 'Hubo un error en la API')

      app = BotClient.new(token)

      app.run_once
    end

    it 'deberia responder con mensaje de ayuda' do
      token = 'fake_token'

      when_i_send_text(token, '/aceptar_oferta')
      then_i_get_text(token, 'Error: El uso del comando es /aceptar_oferta <id_oferta>')

      app = BotClient.new(token)

      app.run_once
    end
  end
end
