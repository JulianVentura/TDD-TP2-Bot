class RespuestaAutoCotizado
  def initialize(patente, modelo, kilometros, anio, id_prop, estado, precio) # rubocop:disable Metrics/ParameterLists
    @patente = patente
    @modelo = modelo
    @kilometros = kilometros
    @anio = anio
    @id_prop = id_prop
    @estado = estado
    @precio = precio
  end

  def ==(other)
    ((other.patente == @patente) &&
      (other.modelo == @modelo) &&
      (other.kilometros == @kilometros) &&
      (other.anio == @anio) &&
      (other.id_prop == @id_prop) &&
      (other.estado == @estado) &&
      (other.precio == @precio))
  end

  attr_reader :patente, :modelo, :kilometros, :anio, :id_prop, :estado, :precio
end
