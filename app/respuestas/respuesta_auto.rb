class RespuestaAuto
  def initialize(patente, modelo, kilometros, anio, id_prop, estado, es_fiubak)
    @patente = patente
    @modelo = modelo
    @kilometros = kilometros
    @anio = anio
    @id_prop = id_prop
    @estado = estado
    @es_fiubak = es_fiubak
  end

  def ==(other) # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    other.class == self.class && ((other.patente == @patente) &&
      (other.modelo == @modelo) &&
      (other.kilometros == @kilometros) &&
      (other.anio == @anio) &&
      (other.id_prop == @id_prop) &&
      (other.estado == @estado) &&
      (other.es_fiubak == @es_fiubak))
  end

  def esta_cotizado?
    false
  end

  attr_reader :patente, :modelo, :kilometros, :anio, :id_prop, :estado, :es_fiubak
end
