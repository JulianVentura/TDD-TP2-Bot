class DatosConsultarOfertasRealizadas
  def initialize(id_usuario)
    @id_usuario = id_usuario
  end

  def ==(other)
    (other.id_usuario == @id_usuario)
  end

  attr_reader :id_usuario
end
