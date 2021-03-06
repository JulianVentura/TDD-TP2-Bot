#language: es
@manual
Característica: Publicar P2P

  Antecedentes:
    Dado que existe un usuario con nombre "juan" y mail "juan@test.com"
    Y que tiene un auto modelo "Fiat Uno", patente "ABC123", kilometros 100000 y año 1999
    Y se cotiza el auto de patente "ABC123" con precio 120000

  Escenario: P1 - Publicacion P2P exitosa
    Cuando ingreso el comando "/publicar_p2p ABC123, 240000"
    Entonces recibo mensaje de publicacion exitosa

  Escenario: P2 - Publicacion fallida por falta de datos
    Cuando ingreso el comando "/publicar_p2p ABC123"
    Entonces recibo mensaje de error por falta de datos

  Escenario: P3 - Publicacion fallida por auto inexistente
    Cuando ingreso el comando "/publicar_p2p JHK657, 240000"
    Entonces recibo mensaje de error por auto inexistente

  Escenario: P4 - Publicacion fallida por auto no cotizado
    Dado que tiene un auto modelo "Ford Fiesta", patente "NOC435", kilometros 2000 y año 2004
    Cuando ingreso el comando "/publicar_p2p NOC435, 240000"
    Entonces recibo mensaje de error por auto no cotizado

  Escenario: P5 - Publicacion fallida por usuario incorrecto
    Dado que existe otro usuario con nombre "jorge" y mail "jorge@test.com"
    Cuando el otro usuario ingresa el comando "/publicar_p2p ABC123, 240000"
    Entonces recibo mensaje de error por usuario incorrecto

  Escenario: P6 - Publicacion P2P fallida por cotizacion menor a precio Fiubak
    Cuando ingreso el comando "/publicar_p2p ABC123, 100"
    Entonces recibo mensaje de error por precio menor al cotizado por Fiubak
