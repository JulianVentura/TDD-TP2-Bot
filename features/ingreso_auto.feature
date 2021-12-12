#language:es
@manual
Característica: Ingreso de auto al sistema

  Antecedentes:
    Dado que existe un usuario con nombre "juan" y mail "juan@test.com"

  Escenario: IA1 - Ingreso de auto exitoso
    Cuando ingreso el comando "/ingresar_auto Fiat Uno, ABC123, 100000, 1999"
    Entonces recibo mensaje de ingreso de auto exitoso

  Escenario: IA2 - Ingreso fallido por falta de datos
    Cuando ingreso el comando "/ingresar_auto Fiat Uno, 1999"
    Entonces recibo mensaje de error por ingreso de auto fallido por falta de datos

  Escenario: IA3 - Ingreso fallido por patente repetida
    Dado que existe un auto modelo "Fiat Uno", patente "ABC123", kilometros 100000 y año 1999
    Cuando ingreso el comando "/ingresar_auto Ford Fiesta, ABC123, 10000, 2010"
    Entonces recibo mensaje de error por ingreso de auto fallido por patente repetida
