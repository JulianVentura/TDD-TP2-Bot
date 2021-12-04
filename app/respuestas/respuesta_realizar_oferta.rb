class RespuestaRealizarOferta
  def initialize(patente)
    @patente = patente
  end

  def ==(other)
    other.class == self.class && (other.patente == @patente)
  end

  attr_reader :patente
end
