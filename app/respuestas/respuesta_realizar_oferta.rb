class RespuestaRealizarOferta
  def initialize(id_oferta, id_ofertante, patente, precio)
    @id_oferta = id_oferta
    @id_ofertante = id_ofertante
    @patente = patente
    @precio = precio
  end

  def ==(other)
    other.class == self.class &&
      (other.patente == @patente) &&
      (other.id_oferta == @id_oferta) &&
      (other.id_ofertante == @id_ofertante) &&
      (other.precio == @precio)
  end

  attr_reader :id_oferta, :id_ofertante, :patente, :precio
end
