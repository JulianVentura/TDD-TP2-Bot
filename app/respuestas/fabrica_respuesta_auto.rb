require './app/respuestas/respuesta_auto'
class FabricaRespuestaAuto
  def crear(patente, modelo, kilometros, anio, id_prop, estado)
    RespuestaAuto.new(patente, modelo, kilometros, anio, id_prop, estado)
  end
end
