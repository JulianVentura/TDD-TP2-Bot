@manual
Característica: Cotizacion de autos

  Antecedentes:
    Dado que me registre como "juan" y mail "juan@test.com"
    Y que tengo un auto modelo "Fiat Uno", patente "ABC123", kilometros 100000 y año 1999

  Escenario: CO1 - Consulta de cotizado
    Cuando se cotiza el auto de patente "ABC123" con precio 120000
    Y ingreso el comando "/consultar_mis_autos"
    Entonces recibo el mensaje "#1 ABC123, Cotizado, 120000"
