class DatosPublicarP2P
  def initialize(patente, id_prop, precio)
    @patente = patente
    @id_prop = id_prop
    @precio = precio
  end

  def ==(other)
    (
      (other.patente == @patente) &&
      (other.id_prop == @id_prop) &&
      (other.precio == @precio)
    )
  end

  attr_reader :patente, :id_prop, :precio
end
