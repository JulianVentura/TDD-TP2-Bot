#language:es
@manual
Característica: Comprar auto a FIUBAK

Antecedentes:
  Dado que me registre como "juan" y mail "juan@test.com"
  Y que existe un auto publicado por FIUBAK modelo "Fiat Uno", patente "ABC123", kilometros 100000 y año 1999

Escenario: RF1 - Compra exitosa
  Cuando ingreso el comando "/comprar ABC123"
  Entonces recibo una confirmacion de compra
