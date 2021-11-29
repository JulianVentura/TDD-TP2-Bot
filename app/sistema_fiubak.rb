require_relative './respuestas/respuesta_registro'
require './app/error_api'

class SistemaFiubak
  def initialize
    @servicio = Faraday.new(
      url: 'http://webapp:3000',
      headers: { 'Content-Type' => 'application/json' }
    )
  end

  def registrar(nombre, email, id)
    endpoint = '/usuarios'
    respuesta = @servicio.post(endpoint) do |req|
      req.body = { nombre: nombre, email: email, id: id }.to_json
    end

    respuesta_json = JSON.parse(respuesta.body)

    raise ErrorApi, respuesta_json['error'] unless respuesta.status == 201

    nombre = respuesta_json['nombre']
    email = respuesta_json['email']
    id = respuesta_json['id']

    RespuestaRegistro.new(nombre, email, id)
  end
end
