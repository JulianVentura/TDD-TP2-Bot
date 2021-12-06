#language: es
@manual
Característica: Consultar ofertas recibidas

  Antecedentes:
    Dado que me registre como "juan" y mail "juan@test.com"
    Y que tengo un auto modelo "Fiat Uno", patente "ABC123", kilometros 100000 y año 1999
    Y se cotiza el auto de patente "ABC123" con precio 120000
    Y decido publicarlo como p2p con precio 240000

  Escenario: CORV1 - Consulta de ofertas recibidas con una oferta
    Dado que realizaron una oferta a mi auto de patente ABC123 con oferta 50000 e id_oferta 123
    Cuando ingreso el comando "/consultar_ofertas_recibidas ABC123"
    Entonces recibo el mensaje "#123 ABC123, $50000, Rechazada"

  Escenario: CORV2 - Consulta de ofertas recibidas sin ofertas
    Dado que tengo un auto modelo "Fiat Uno", patente "DHG456", kilometros 100000 y año 1999
    Cuando ingreso el comando "/consultar_ofertas_recibidas DHG456"
    Entonces recibo el mensaje "No se han recibido ofertas sobre el auto de patente DHG456"

  Escenario: CORV3 - Consulta de ofertas fallida por auto inexistente
    Dado que tengo un auto modelo "Fiat Uno", patente "DHG456", kilometros 100000 y año 1999
    Cuando ingreso el comando "/consultar_ofertas_recibidas TGF657"
    Entonces recibo el mensaje de error "Error: auto inexistente"
