class DatosRegistro
  def initialize(nombre, email, id)
    @nombre = nombre
    @email = email
    @id = id
  end

  attr_reader :nombre, :email, :id
end
