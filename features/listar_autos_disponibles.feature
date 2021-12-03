@manual
Característica: Listar autos disponibles para comprar

Antecedentes:
Dado que existe un usuario con nombre "juan" y mail "juan@test.com"

Escenario: LA1 - Listado de un unico auto
Dado que existe un auto publicado por Fiubak modelo "Fiat Uno", patente "ABC123", kilometros 100000 y año 1999
Cuando ingreso el comando "/listar_autos"
Entonces recibo la respuesta "#1 Fiat Uno, ABC123, 100000, 1999, Fiubak"

Escenario: LA2 - Listado sin autos
Cuando ingreso el comando "/listar_autos"
Entonces recibo la respuesta "No hay autos a la venta"

Escenario: LA3 - Listado con 3 autos
Dado que existe un auto publicado por Fiubak modelo "Fiat Uno", patente "ABC123", kilometros 100000 y año 1999
Y que existe un auto publicado por Fiubak modelo "Volkswagen Golf", patente "AB123CD", kilometros 0 y año 2019
Y que existe un auto publicado por Fiubak modelo "Ford Fiesta", patente "ZED124", kilometros 250000 y año 1987
Cuando ingreso el comando "/listar_autos"
Entonces recibo en la respuesta "#1 Fiat Uno, ABC123, 100000, 1999, Fiubak"
Y recibo en la respuesta "#2 Volkswagen Golf, AB123CD, 0, 2019, Fiubak"
Y recibo en la respuesta "#3 Ford Fiesta, ZED124, 250000, 1987, Fiubak"
