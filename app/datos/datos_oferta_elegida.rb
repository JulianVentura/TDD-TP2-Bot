class DatosOfertaElegida
  def initialize(id_oferta)
    @id_oferta = id_oferta
  end

  def ==(other)
    (other.id_oferta == @id_oferta)
  end

  attr_reader :id_oferta
end
