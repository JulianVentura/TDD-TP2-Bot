require 'spec_helper'
require './app/impresora'

describe 'Impresora' do
  it 'deberia devolver un string con la lista de comandos y sus descripciones en ayuda' do # rubocop:disable RSpec/ExampleLength, Metrics/BlockLength
    impresora = Impresora.new

    comandos = [
      '/ayuda',
      '/registrar <nombre>, <mail>',
      '/ingresar_auto <modelo>, <patente>, <kilometros>, <año>',
      '/consultar_mis_autos',
      '/listar_autos',
      '/vender_a_fiubak <patente>',
      '/publicar_p2p <patente>, <precio>',
      '/comprar <patente>',
      '/realizar_oferta <patente>, <precio>',
      '/rechazar_oferta <id_oferta>',
      '/aceptar_oferta <id_oferta>',
      '/consultar_ofertas_recibidas <patente>',
      '/consultar_ofertas_realizadas'
    ]

    descripciones = [
      'Muestra una lista de los comandos disponibles con su descripción',
      'Registro en Fiubak con nombre y mail',
      'Ingresa un auto a Fiubak',
      'Muestra una lista de tus autos',
      'Muestra una lista de los autos en venta',
      'Vende tu auto a Fiubak aceptando la cotización',
      'Publica tu auto peer to peer con el precio que desees, siempre que sea mayor a la cotización',
      'Compra un auto a Fiubak',
      'Realiza una oferta por el precio que creas conveniente a un auto publicado como peer to peer',
      'Rechaza una oferta realizada a uno de tus autos publicados',
      'Acepta una oferta realizada a uno de tus autos publicados',
      'Muestra una lista de ofertas recibidas a uno de tus autos publicados',
      'Muestra una lista las ofertas que realizaste'
    ]

    respuesta = impresora.ayuda

    comandos.each { |comando| expect(respuesta).to include comando }
    descripciones.each { |descripcion| expect(respuesta).to include descripcion }
  end
end
