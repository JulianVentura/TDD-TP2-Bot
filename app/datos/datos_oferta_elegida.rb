class DatosOfertaElegida
  def initialize(id_vendedor, id_oferta)
    @id_oferta = id_oferta
    @id_vendedor = id_vendedor
  end

  def ==(other)
    (other.id_oferta == @id_oferta) &&
      (other.id_vendedor == @id_vendedor)
  end

  attr_reader :id_oferta, :id_vendedor
end
