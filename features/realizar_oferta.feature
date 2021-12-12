#language: es
@manual
Característica: Realizar oferta

  Antecedentes:
    Dado que existe un usuario con id "123456", nombre "juan" y mail "juan@test.com"
    Y que tiene un auto modelo "Fiat Uno", patente "ABC123", kilometros 100000 y año 1999
    Y se cotiza el auto de patente "ABC123" con precio 120000
    Y decide publicarlo como p2p

  Escenario: RO1 - Realizacion de oferta exitosa
    Cuando ingreso el comando "/realizar_oferta ABC123, 5000"
    Entonces recibo mensaje de oferta exitosa

  Escenario: RO2 - Realizacion de oferta fallida por publicacion inexistente
    Cuando ingreso el comando "/realizar_oferta GHJ456, 5000"
    Entonces recibo mensaje de error por publicacion inexistente

  Escenario: RO3 -  Realizacion de oferta fallida por falta de datos
    Cuando ingreso el comando "/realizar_oferta ABC123"
    Entonces recibo mensaje de error por falta de datos

  Escenario: RO4 - Realizacion de oferta fallida por publicacion inexistente
    Dado que existe un auto modelo "Fiat Uno", patente "FGH123", kilometros 100000 y año 1999
    Cuando ingreso el comando "/realizar_oferta FGH123, 5000"
    Entonces recibo mensaje de error por publicacion inexistente

  Escenario: RO5 - Realizacion de oferta fallida por oferta a publicacion fiubak
    Dado que existe un auto publicado por Fiubak modelo "Fiat Uno", patente "HHH888", kilometros 100000, año 1999 y precio 15000
    Cuando ingreso el comando "/realizar_oferta HHH888, 5000"
    Entonces recibo mensaje de error por publicacion de fiubak

  Escenario: RO6 - Realizacion de oferta fallida por oferta duplicada
    Cuando ingreso el comando "/realizar_oferta ABC123, 1000"
    Cuando ingreso el comando "/realizar_oferta ABC123, 5000"
    Entonces recibo mensaje de error por ofertar mas de una vez
