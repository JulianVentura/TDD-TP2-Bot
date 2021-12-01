require_relative './respuestas/respuesta_registro'
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
end
