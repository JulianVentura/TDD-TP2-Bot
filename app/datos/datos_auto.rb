class DatosAuto
  def initialize(modelo, patente, kilometros, anio, id_prop)
    @patente = patente
    @modelo = modelo
    @kilometros = kilometros
    @anio = anio
    @id_prop = id_prop
  end

  def ==(other)
    ((other.patente == @patente) &&
      (other.modelo == @modelo) &&
      (other.kilometros == @kilometros) &&
      (other.anio == @anio) &&
      (other.id_prop == @id_prop))
  end

  attr_reader :patente, :modelo, :kilometros, :anio, :id_prop
end
