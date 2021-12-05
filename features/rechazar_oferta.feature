#language: es
@manual
Característica: Rechazar oferta
  
  Antecedentes:
    Dado que existe un usuario con id "123456", nombre "juan" y mail "juan@test.com"
    Y que tiene un auto modelo "Fiat Uno", patente "ABC123", kilometros 100000 y año 1999
    Y se cotiza el auto de patente "ABC123" con precio 120000
    Y decide publicarlo como p2p
    y comprador decide realizar una oferta con id_oferta 995

  Escenario: RO1 - Rechazo de oferta exitoso
    Cuando ingreso el comando "/rechazar_oferta 995"
    Entonces recibo mensaje de oferta rechazada

  Escenario: RO2 - Rechazo de oferta fallida por oferta inexistente
    Cuando ingreso el comando "/rechazar_oferta 9"
    Entonces recibo mensaje de error por oferta inexistente

  Escenario: RO3 -  Rechazo de oferta fallida por falta de datos
    Cuando ingreso el comando "/rechazar_oferta"
    Entonces recibo mensaje de error por falta de datos

  Escenario: RO4 -  Rechazo de oferta fallida por id no coincidente
    Cuando otro usuario ingresa el comando "/rechazar_oferta 995"
    Entonces recibo mensaje de error por id no coincidente

  Escenario: RO5 -  Rechazo de oferta fallida por rechazar multiples veces
    Dado ingreso el comando "/rechazar_oferta 995"
    Cuando ingreso el comando "/rechazar_oferta 995"
    Entonces recibo mensaje de error por oferta no pendiente
