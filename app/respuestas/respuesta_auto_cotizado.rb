class RespuestaAutoCotizado < RespuestaAuto
  def initialize(patente, modelo, kilometros, anio, id_prop, estado, precio)
    @precio = precio
    super(patente, modelo, kilometros, anio, id_prop, estado)
  end

  def ==(other)
    super(other) && (other.precio == @precio)
  end

  def esta_cotizado?
    true
  end

  attr_reader :patente, :modelo, :kilometros, :anio, :id_prop, :estado, :precio
end
