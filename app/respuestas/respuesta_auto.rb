class RespuestaAuto
  def initialize(patente, modelo, kilometros, anio, id_prop, estado) # rubocop:disable Metrics/ParameterLists
    @patente = patente
    @modelo = modelo
    @kilometros = kilometros
    @anio = anio
    @id_prop = id_prop
    @estado = estado
  end

  def ==(other)
    ((other.patente == @patente) &&
      (other.modelo == @modelo) &&
      (other.kilometros == @kilometros) &&
      (other.anio == @anio) &&
      (other.id_prop == @id_prop) &&
      (other.estado == @estado))
  end

  attr_reader :patente, :modelo, :kilometros, :anio, :id_prop, :estado
end
