#language:es
@manual
Característica: Comprar auto a FIUBAK

  Antecedentes:
    Dado que me registre como "juan" y mail "juan@test.com"
    Y que existe un auto publicado por FIUBAK modelo "Fiat Uno", patente "ABC123", kilometros 100000 y año 1999

  Escenario: RF1 - Compra exitosa
    Cuando ingreso el comando "/comprar ABC123"
    Entonces recibo una confirmacion de compra

  Escenario: RF2 - Compra fallida auto inexistente
    Cuando compro el auto de patente "NOE123"
    Entonces obtengo un mensaje de error por auto no existente

  Escenario: RF3 - Compra fallida auto no en venta
    Dado que existe un auto modelo "Fiat Uno", patente "ZXC123", kilometros 100000 y año 1999
    Cuando compro el auto de patente "ZXC123"
    Entonces obtengo un mensaje de error por auto no en venta

  Escenario: RF4 - Compra fallida al intentar recomprar auto
    Dado que vendi un auto a FIUBAK de patente "FIU123"
    Cuando ingreso el comando "/comprar FIU123"
    Entonces obtengo un mensaje de error por intento de recompra
