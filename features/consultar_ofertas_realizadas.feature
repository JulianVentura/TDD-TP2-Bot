#language: es
@manual
Característica: Consultar ofertas realizadas

  Antecedentes:
    Dado que me registre como "juan" y mail "juan@test.com"

  Escenario: CORC1 - Consulta de ofertas realizadas con una oferta
    Dado que tengo realizada una oferta al auto de patente ABC123 con oferta 50000
    Cuando ingreso el comando "/consultar_ofertas_realizadas"
    Entonces recibo el mensaje "#1 ABC123, 50000, Rechazada"

  Escenario: CORC2 - Consulta de ofertas realizadas sin ofertas
    Cuando ingreso el comando "/consultar_ofertas_realizadas"
    Entonces recibo el mensaje "No tenes ninguna oferta realizada"
