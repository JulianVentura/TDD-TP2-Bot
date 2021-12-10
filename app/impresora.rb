class Impresora
  COMANDOS = {
    ayuda: '/ayuda',
    registrar: '/registrar <nombre>, <mail>',
    ingresar_auto: '/ingresar_auto <modelo>, <patente>, <kilometros>, <año>',
    consultar_autos: '/consultar_mis_autos',
    listar_autos: '/listar_autos',
    vender_fiubak: '/vender_a_fiubak <patente>',
    publicar_p2p: '/publicar_p2p <patente>, <precio>',
    comprar: '/comprar <patente>',
    realizar_oferta: '/realizar_oferta <patente>, <precio>',
    rechazar_oferta: '/rechazar_oferta <id_oferta>',
    aceptar_oferta: '/aceptar_oferta <id_oferta>',
    consultar_ofertas_recibidas: '/consultar_ofertas_recibidas <patente>',
    consultar_ofertas_realizadas: '/consultar_ofertas_realizadas'
  }.freeze

  DESCRIPCIONES = {
    ayuda: 'Muestra una lista de los comandos disponibles con su descripción',
    registrar: 'Registro en Fiubak con nombre y mail',
    ingresar_auto: 'Ingresa un auto a Fiubak',
    consultar_autos: 'Muestra una lista de tus autos',
    listar_autos: 'Muestra una lista de los autos en venta',
    vender_fiubak: 'Vende tu auto a Fiubak aceptando la cotización',
    publicar_p2p: 'Publica tu auto peer to peer con el precio que desees, siempre que sea mayor a la cotización',
    comprar: 'Compra un auto a Fiubak',
    realizar_oferta: 'Realiza una oferta por el precio que creas conveniente a un auto publicado como peer to peer',
    rechazar_oferta: 'Rechaza una oferta realizada a uno de tus autos publicados',
    aceptar_oferta: 'Acepta una oferta realizada a uno de tus autos publicados',
    consultar_ofertas_recibidas: 'Muestra una lista de ofertas recibidas a uno de tus autos publicados',
    consultar_ofertas_realizadas: 'Muestra una lista las ofertas que realizaste'
  }.freeze

  def ayuda
    texto = ''
    i = 0

    COMANDOS.keys.each do |comando|
      i += 1
      texto += "#{COMANDOS[comando]}\n\n#{DESCRIPCIONES[comando]}\n\n"
    end

    texto[0..-3]
  end
end
