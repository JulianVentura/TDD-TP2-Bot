class DatosAuto
  def initialize(patente, modelo, kilometros, anio, id_prop)
    @patente = patente
    @modelo = modelo
    @kilometros = kilometros
    @anio = anio
    @id_prop = id_prop
  end

  attr_reader :patente, :modelo, :kilometros, :anio, :id_prop
end
