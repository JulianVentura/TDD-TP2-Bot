class RespuestaOferta
  def initialize(id_oferta, id_ofertante, patente, precio, estado)
    @id_oferta = id_oferta
    @id_ofertante = id_ofertante
    @patente = patente
    @precio = precio
    @estado = estado
  end

  def ==(other)
    other.class == self.class &&
      (other.patente == @patente) &&
      (other.id_oferta == @id_oferta) &&
      (other.id_ofertante == @id_ofertante) &&
      (other.precio == @precio) &&
      (other.estado == @estado)
  end

  attr_reader :id_oferta, :id_ofertante, :patente, :precio, :estado
end
