class DatosRealizarOferta
  def initialize(id_ofertante, patente, precio)
    # TODO: como el el id que pasamos no es el de un propietario, rompe cuando buscamos el atributo id_prop
    @id_ofertante = id_ofertante
    @patente = patente
    @precio = precio
  end

  def ==(other)
    (
      (other.patente == @patente) &&
      (other.id_ofertante == @id_ofertante) &&
      (other.precio == @precio)
    )
  end

  attr_reader :patente, :id_ofertante, :precio
end
