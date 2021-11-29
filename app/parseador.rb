require './app/datos_registro'

class Parseador
  def parsear_registro(argumentos, id)
    argumentos = argumentos.split(',')
    DatosRegistro.new(argumentos[0], argumentos[1], id)
  end
end
