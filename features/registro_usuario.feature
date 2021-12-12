#language:es
@manual
Característica: Registracion

  Escenario: R1 - Registro exitoso
    Cuando ingreso el comando "/registrar juan, juan@test.com"
    Entonces recibo mensaje de registro exitoso

  Escenario: R2 - Registro fallido por email duplicado
    Dado que existe un usuario con nombre "jorge" y mail "mail@test.com"
    Cuando ingreso el comando "/registrar juan, mail@test.com"
    Entonces recibo mensaje de error por registro fallido

  Escenario: R3 - Registro fallido por falta de argumentos
    Cuando ingreso el comando "/registrar juan"
    Entonces recibo mensaje de error por falta de argumentos
