class RespuestaRealizarOferta
  def initialize(id_oferta, id_ofertante, patente)
    @id_oferta = id_oferta
    @id_ofertante = id_ofertante
    @patente = patente
  end

  def ==(other)
    other.class == self.class &&
      (other.patente == @patente) &&
      (other.id_oferta == @id_oferta) &&
      (other.id_ofertante == @id_ofertante)
  end

  attr_reader :id_oferta, :id_ofertante, :patente
end
