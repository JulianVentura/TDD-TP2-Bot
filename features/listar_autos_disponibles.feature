#language: es
@manual
Característica: Listar autos disponibles para comprar

  Antecedentes:
    Dado que existe un usuario con nombre "juan" y mail "juan@test.com"

  Escenario: LA1 - Listado de un unico auto
    Dado que existe un auto publicado por Fiubak modelo "Fiat Uno", patente "ABC123", kilometros 100000, año 1999 y precio $15000
    Cuando ingreso el comando "/listar_autos"
    Entonces recibo la respuesta "#1 Fiat Uno, ABC123, 100000km, año 1999, $15000, Fiubak"

  Escenario: LA2 - Listado sin autos
    Cuando ingreso el comando "/listar_autos"
    Entonces recibo la respuesta "No hay autos a la venta"

  Escenario: LA3 - Listado con 3 autos
    Dado que existe un auto publicado por Fiubak modelo "Fiat Uno", patente "ABC123", kilometros 100000, año 1999 y precio $15000
    Y que existe un auto publicado por Fiubak modelo "Volkswagen Golf", patente "AB123CD", kilometros 0, año 2019 y precio $200000
    Y que existe un auto publicado por Fiubak modelo "Ford Fiesta", patente "ZED124", kilometros 250000, año 1987 y precio $8000
    Cuando ingreso el comando "/listar_autos"
    Entonces recibo en la respuesta "#1 Fiat Uno, ABC123, 100000km, año 1999, $15000, Fiubak"
    Y recibo en la respuesta "#2 Volkswagen Golf, AB123CD, 0km, año 2019, $200000, Fiubak"
    Y recibo en la respuesta "#3 Ford Fiesta, ZED124, 250000km, año 1987, $8000, Fiubak"
