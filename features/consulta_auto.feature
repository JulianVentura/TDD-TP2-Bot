#language:es
@manual
Característica: Consultar estado autos

Antecedentes:
  Dado que me registre como "juan" y mail "juan@test.com"
  Y que tengo un auto modelo "Fiat Uno", patente "ABC123", kilometros 100000 y año 1999

Escenario: CA1 - Consulta de estado en revisión
  Cuando ingreso el comando "/consultar_mis_autos"
  Entonces recibo el mensaje "#1 ABC123, En revision"
