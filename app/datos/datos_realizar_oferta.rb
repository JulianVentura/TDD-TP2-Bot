class DatosRealizarOferta
  def initialize(patente, id_ofertante, precio)
    # TODO: como el el id que pasamos no es el de un propietario, rompe cuando buscamos el atributo id_prop
    @patente = patente
    @id_ofertante = id_ofertante
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
