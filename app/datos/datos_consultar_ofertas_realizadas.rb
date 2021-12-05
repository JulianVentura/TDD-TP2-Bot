class DatosConsultarOfertasRealizadas
  def initialize(id_prop)
    @id_prop = id_prop
  end

  def ==(other)
    (other.id_prop == @id_prop)
  end

  attr_reader :id_prop
end
