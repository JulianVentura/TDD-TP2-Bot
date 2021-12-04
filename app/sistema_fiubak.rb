require_relative './respuestas/respuesta_registro'
require_relative './respuestas/respuesta_auto'
require_relative './respuestas/fabrica_respuesta_auto'
require_relative './respuestas/respuesta_realizar_oferta'
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
      req.body = { patente: datos_auto.patente, modelo: datos_auto.modelo, id_prop: datos_auto.id_prop,
                   kilometros: datos_auto.kilometros, anio: datos_auto.anio }.to_json
    end

    respuesta_json = JSON.parse(respuesta.body)

    raise ErrorApi, respuesta_json['error'] unless respuesta.status == 201

    RespuestaAuto.new(respuesta_json['patente'], respuesta_json['modelo'], respuesta_json['kilometros'],
                      respuesta_json['anio'], respuesta_json['id_prop'], respuesta_json['estado'], respuesta_json['es_fiubak'])
  end

  def consultar_mis_autos(id_prop) # rubocop:disable Metrics/AbcSize
    endpoint = "/usuarios/#{id_prop}/autos"
    respuesta = @servicio.get(endpoint)

    respuesta_json = JSON.parse(respuesta.body)

    raise ErrorApi, respuesta_json['error'] unless respuesta.status == 200

    autos = []

    respuesta_json.each do |auto|
      autos.append(FabricaRespuestaAuto.new.crear(auto['patente'], auto['modelo'], auto['kilometros'], auto['anio'],
                                                  auto['id_prop'], auto['estado'], auto['es_fiubak'], auto['precio']))
    end

    autos
  end

  def vender_a_fiubak(datos_compraventa_fiubak) # rubocop:disable Metrics/AbcSize
    endpoint = "/autos/#{datos_compraventa_fiubak.patente}/vender_a_fiubak"
    respuesta = @servicio.post(endpoint) do |req|
      req.body = { id_prop: datos_compraventa_fiubak.id_prop }.to_json
    end

    respuesta_json = JSON.parse(respuesta.body)

    raise ErrorApi, respuesta_json['error'] unless respuesta.status == 200

    RespuestaAutoCotizado.new(respuesta_json['patente'], respuesta_json['modelo'], respuesta_json['kilometros'],
                              respuesta_json['anio'], respuesta_json['id_prop'], respuesta_json['estado'],
                              respuesta_json['es_fiubak'], respuesta_json['precio'])
  end

  def listar_autos # rubocop:disable Metrics/AbcSize
    endpoint = '/autos'
    respuesta = @servicio.get(endpoint)

    respuesta_json = JSON.parse(respuesta.body)

    raise ErrorApi, respuesta_json['error'] unless respuesta.status == 200

    autos = []

    respuesta_json.each do |auto|
      autos.append(FabricaRespuestaAuto.new.crear(auto['patente'], auto['modelo'], auto['kilometros'], auto['anio'],
                                                  auto['id_prop'], auto['estado'], auto['es_fiubak'], auto['precio']))
    end

    autos
  end

  def publicar_p2p(datos_auto) # rubocop:disable Metrics/AbcSize
    endpoint = "/autos/#{datos_auto.patente}/publicar_p2p"
    respuesta = @servicio.post(endpoint) do |req|
      req.body = { id_prop: datos_auto.id_prop, precio: datos_auto.precio }.to_json
    end

    respuesta_json = JSON.parse(respuesta.body)

    raise ErrorApi, respuesta_json['error'] unless respuesta.status == 200

    FabricaRespuestaAuto.new.crear(respuesta_json['patente'], respuesta_json['modelo'], respuesta_json['kilometros'],
                                   respuesta_json['anio'], respuesta_json['id_prop'], respuesta_json['estado'],
                                   respuesta_json['es_fiubak'], respuesta_json['precio'])
  end

  def comprar(datos_compraventa_fiubak) # rubocop:disable Metrics/AbcSize
    endpoint = "/autos/#{datos_compraventa_fiubak.patente}/comprar"
    respuesta = @servicio.post(endpoint) do |req|
      req.body = { id_prop: datos_compraventa_fiubak.id_prop }.to_json
    end

    respuesta_json = JSON.parse(respuesta.body)

    raise ErrorApi, respuesta_json['error'] unless respuesta.status == 200

    FabricaRespuestaAuto.new.crear(respuesta_json['patente'], respuesta_json['modelo'], respuesta_json['kilometros'],
                                   respuesta_json['anio'], respuesta_json['id_prop'], respuesta_json['estado'],
                                   respuesta_json['es_fiubak'], respuesta_json['precio'])
  end

  def realizar_oferta(datos_oferta) # rubocop:disable Metrics/AbcSize
    endpoint = "/autos/#{datos_oferta.patente}/realizar_oferta"
    respuesta = @servicio.post(endpoint) do |req|
      req.body = { id_ofertante: datos_oferta.id_ofertante, precio: datos_oferta.precio }.to_json
    end

    respuesta_json = JSON.parse(respuesta.body)

    raise ErrorApi, respuesta_json['error'] unless respuesta.status == 200

    RespuestaRealizarOferta.new(respuesta_json['id_oferta'], respuesta_json['id_ofertante'], respuesta_json['patente'], respuesta_json['precio'], respuesta_json['estado'])
  end

  def rechazar_oferta(datos_oferta_elegida)
    endpoint = "/ofertas/#{datos_oferta_elegida.id_oferta}/rechazar_oferta"
    respuesta = @servicio.post(endpoint) do |req|
      req.body = { id_oferta: datos_oferta_elegida.id_oferta }.to_json
    end
    # TODO: POST o PATCH?

    respuesta_json = JSON.parse(respuesta.body)

    RespuestaRealizarOferta.new(respuesta_json['id_oferta'], respuesta_json['id_ofertante'], respuesta_json['patente'], respuesta_json['precio'], respuesta_json['estado'])
  end
end
