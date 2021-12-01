class RespuestaAutoCotizado < RespuestaAuto
  def initialize(patente, modelo, kilometros, anio, id_prop, estado, precio) # rubocop:disable Metrics/ParameterLists
    @precio = precio
    super(patente, modelo, kilometros, anio, id_prop, estado)
  end

  def ==(other)
    other.class == self.class && super(other) && (other.precio == @precio)
  end

  attr_reader :patente, :modelo, :kilometros, :anio, :id_prop, :estado, :precio
end
