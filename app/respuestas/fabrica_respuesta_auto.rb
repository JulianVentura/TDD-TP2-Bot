require './app/respuestas/respuesta_auto'
require './app/respuestas/respuesta_auto_cotizado'
class FabricaRespuestaAuto
  def crear(patente, modelo, kilometros, anio, id_prop, estado, es_fiubak, precio = 0) # rubocop:disable Metrics/ParameterLists
    return RespuestaAuto.new(patente, modelo, kilometros, anio, id_prop, estado, es_fiubak) if estado == 'En revision'

    RespuestaAutoCotizado.new(patente, modelo, kilometros, anio, id_prop, estado, es_fiubak, precio)
  end
end
