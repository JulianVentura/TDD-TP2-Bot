class RespuestaAuto
  def initialize(patente, modelo, kilometros, anio, id_prop, estado)
    @patente = patente
    @modelo = modelo
    @kilometros = kilometros
    @anio = anio
    @id_prop = id_prop
    @estado = estado
  end

  def ==(other) # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize
    other.class == self.class && ((other.patente == @patente) &&
      (other.modelo == @modelo) &&
      (other.kilometros == @kilometros) &&
      (other.anio == @anio) &&
      (other.id_prop == @id_prop) &&
      (other.estado == @estado))
  end

  def esta_cotizado?
    false
  end

  attr_reader :patente, :modelo, :kilometros, :anio, :id_prop, :estado
end
