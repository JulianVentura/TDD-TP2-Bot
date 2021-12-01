class ErrorApi < StandardError
  def initialize(mensaje)
    @mensaje = mensaje
    super()
  end

  attr_reader :mensaje
end
