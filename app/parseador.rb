require './app/datos/datos_registro'
require './app/datos/datos_auto'
require './app/datos/datos_venta_fiubak'
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

    DatosAuto.new(argumentos[0].strip, argumentos[1].strip, argumentos[2].to_i, argumentos[3].to_i, id)
  end

  def parsear_vender_a_fiubak(argumentos, id)
    raise ErrorParseo if argumentos.nil?

    argumentos = argumentos.split(',')

    raise ErrorParseo if argumentos.size != 1

    DatosVentaFiubak.new(argumentos[0].strip, id)
  end
end
