class DatosVentaFiubak
  def initialize(_patenteid_prop)
    @patente = patente
    @id_prop = id_prop
  end

  def ==(other)
    ((other.patente == @patente) &&
      (other.id_prop == @id_prop))
  end

  attr_reader :patente, :id_prop
end
