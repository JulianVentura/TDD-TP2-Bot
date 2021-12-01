require_relative './respuestas/respuesta_registro'
require_relative './respuestas/respuesta_auto'
require './app/errores/error_api'

class SistemaFiubak
  def initialize
    @servicio = Faraday.new(
      url: ENV['URL_BASE'] || 'http://localhost:3000',
      headers: { 'Content-Type' => 'application/json' }
    )
  end

  def registrar(datos_registro)
    endpoint = '/usuarios'
    respuesta = @servicio.post(endpoint) do |req|
      req.body = { nombre: datos_registro.nombre, email: datos_registro.email, id: datos_registro.id }.to_json
    end

    respuesta_json = JSON.parse(respuesta.body)

    raise ErrorApi, respuesta_json['error'] unless respuesta.status == 201

    RespuestaRegistro.new(respuesta_json['nombre'], respuesta_json['email'], respuesta_json['id'])
  end

  def ingresar_auto(datos_auto) # rubocop:disable Metrics/AbcSize
    endpoint = '/autos'
    respuesta = @servicio.post(endpoint) do |req|
      req.body = { patente: datos_auto.patente, modelo: datos_auto.modelo, id: datos_auto.id_prop, kilometros: datos_auto.kilometros, anio: datos_auto.anio }.to_json
    end

    respuesta_json = JSON.parse(respuesta.body)

    RespuestaAuto.new(respuesta_json['patente'], respuesta_json['modelo'], respuesta_json['kilometros'], respuesta_json['anio'], respuesta_json['id'], respuesta_json['estado'])
  end
end
