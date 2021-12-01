require_relative './respuestas/respuesta_registro'
require_relative './respuestas/respuesta_auto'
require_relative './respuestas/fabrica_respuesta_auto'
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
      req.body = { patente: datos_auto.patente, modelo: datos_auto.modelo, id_prop: datos_auto.id_prop, kilometros: datos_auto.kilometros, anio: datos_auto.anio }.to_json
    end

    respuesta_json = JSON.parse(respuesta.body)

    raise ErrorApi, respuesta_json['error'] unless respuesta.status == 201

    RespuestaAuto.new(respuesta_json['patente'], respuesta_json['modelo'], respuesta_json['kilometros'], respuesta_json['anio'], respuesta_json['id_prop'], respuesta_json['estado'])
  end

  def consultar_mis_autos(id_prop) # rubocop:disable Metrics/AbcSize
    endpoint = "/autos/#{id_prop}"
    respuesta = @servicio.get(endpoint)

    respuesta_json = JSON.parse(respuesta.body)

    raise ErrorApi, respuesta_json['error'] unless respuesta.status == 200

    autos = []

    respuesta_json.each do |auto|
      autos.append(FabricaRespuestaAuto.new.crear(auto['patente'], auto['modelo'], auto['kilometros'], auto['anio'], auto['id_prop'], auto['estado'], auto['precio']))
    end

    autos
  end
end
