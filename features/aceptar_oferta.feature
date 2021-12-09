#language:es
@manual
Característica: Aceptar oferta

  Antecedentes:
    Dado que existe un usuario con id "123456", nombre "juan" y mail "ju...@test.com"
    Y que tiene un auto modelo "Fiat Uno", patente "ABC123", kilometros 100000 y año 1999
    Y se cotiza el auto de patente "ABC123" con precio 120000
    Y decide publicarlo como p2p con precio 240000
    Y comprador decide realizar una oferta con id_oferta 995

  Escenario: AO1 - Aceptacion de oferta exitosa
    Cuando ingreso el comando "/aceptar_oferta 995"
    Entonces recibo mensaje de oferta aceptada

  Escenario: AO2 - Aceptacion de oferta fallida por oferta inexistente
    Cuando ingreso el comando "/aceptar_oferta 9"
    Entonces recibo mensaje de error por oferta inexistente

  Escenario: AO3 -  Aceptacion de oferta fallida por falta de datos
    Cuando ingreso el comando "/aceptar_oferta"
    Entonces recibo mensaje de error por falta de datos

  Escenario: AO4 -  Aceptacion de oferta fallida por estado de oferta no pendiente
    Cuando ingreso el comando "/aceptar_oferta 995"
    Cuando ingreso el comando "/aceptar_oferta 995"
    Entonces recibo mensaje de error por oferta no pendiente

  Escenario: AO5 - Aceptacion de oferta deja al auto como vendido
    Cuando ingreso el comando "/aceptar_oferta 995"
    Y se listan los autos en venta
    Entonces el auto de patente "ABC123" no se encuentra
