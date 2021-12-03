class RespuestaAutoCotizado < RespuestaAuto
  def initialize(patente, modelo, kilometros, anio, id_prop, estado, es_fiubak, precio) # rubocop:disable Metrics/ParameterLists
    @precio = precio
    super(patente, modelo, kilometros, anio, id_prop, estado, es_fiubak)
  end

  def ==(other)
    super(other) && (other.precio == @precio)
  end

  def esta_cotizado?
    true
  end

  attr_reader :precio
end
