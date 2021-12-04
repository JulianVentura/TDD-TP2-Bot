require './app/datos/datos_registro'
require './app/datos/datos_auto'
require './app/datos/datos_compra_venta_fiubak'
require './app/datos/datos_publicar_p2p'
require './app/datos/datos_realizar_oferta'
require './app/errores/error_parseo'

class Parseador
  def parsear_registro(argumentos, id)
    tiene_argumentos?(argumentos)

    argumentos = argumentos.split(',')

    raise ErrorParseo if argumentos.size != 2

    DatosRegistro.new(argumentos[0], argumentos[1].strip, id)
  end

  def parsear_ingresar_auto(argumentos, id)
    tiene_argumentos?(argumentos)

    argumentos = argumentos.split(',')

    raise ErrorParseo if argumentos.size != 4

    DatosAuto.new(argumentos[0].strip, argumentos[1].strip, argumentos[2].to_i, argumentos[3].to_i, id)
  end

  def parsear_compraventa_a_fiubak(argumentos, id)
    tiene_argumentos?(argumentos)

    argumentos = argumentos.split(',')

    raise ErrorParseo if argumentos.size != 1

    DatosCompraVentaFiubak.new(argumentos[0].strip, id)
  end

  def parsear_publicar_p2p(argumentos, id)
    tiene_argumentos?(argumentos)

    argumentos = argumentos.split(',')

    raise ErrorParseo if argumentos.size != 2

    DatosPublicarP2P.new(argumentos[0].strip, id, argumentos[1].to_i)
  end

  def parsear_realizar_oferta(argumentos, id)
    tiene_argumentos?(argumentos)

    argumentos = argumentos.split(',')

    raise ErrorParseo if argumentos.size != 2

    DatosRealizarOferta.new(id, argumentos[0].strip, argumentos[1].to_i)
  end

  private

  def tiene_argumentos?(argumentos)
    raise ErrorParseo if argumentos.nil?
  end
end
