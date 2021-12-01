require './app/datos/datos_registro'
require './app/errores/error_parseo'

class Parseador
  def parsear_registro(argumentos, id)
    raise ErrorParseo if argumentos.nil?

    argumentos = argumentos.split(',')

    raise ErrorParseo if argumentos.size != 2

    DatosRegistro.new(argumentos[0], argumentos[1].strip, id)
  end

  def parsear_ingresar_auto(argumentos, id)
    raise ErrorParseo if argumentos.nil?

    argumentos = argumentos.split(',')

    raise ErrorParseo if argumentos.size != 4

    DatosAuto.new(argumentos[0].strip, argumentos[1].strip, argumentos[2], argumentos[3], id)
  end
end
