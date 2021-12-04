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
