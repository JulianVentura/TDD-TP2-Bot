@manual
Característica: Venta a FIUBAK

Antecedentes:
Dado que me registre como "juan" y mail "juan@test.com"
Y que tengo un auto modelo "Fiat Uno", patente "ABC123", kilometros 100000 y año 1999
Y me lo cotizan con un precio de 120000

Escenario: VF1 - Confirmacion de venta a FIUBAK
Cuando ingreso el comando "/vender_a_fiubak ABC123"
Entonces recibo una confirmacion de venta
 
Escenario: VF2 - Entrega de llaves
Cuando ingreso el comando "/vender_a_fiubak ABC123"
Y se realiza la entrega de llaves
Y ingreso el comando "/consultar_mis_autos"
Entonces recibo el mensaje "No tenes autos registrados aún" 