require './app/respuestas/respuesta_auto'
require './app/respuestas/respuesta_auto_cotizado'
class FabricaRespuestaAuto
  def crear(patente, modelo, kilometros, anio, id_prop, estado, precio = 0)
    return RespuestaAuto.new(patente, modelo, kilometros, anio, id_prop, estado) if estado == 'En revision'

    RespuestaAutoCotizado.new(patente, modelo, kilometros, anio, id_prop, estado, precio)
  end
end
