require 'spec_helper'
require './app/parseador'
require './app/errores/error_parseo'
require './app/datos/datos_auto'
require './app/datos/datos_compra_venta_fiubak'

describe 'Parseador' do
  it 'parsear_registro devuelve un DatosRegistro con los datos parseados' do
    nombre = 'juan'
    email = 'juan@mail.com'
    id = 5
    argumentos = "#{nombre},#{email}"

    datos = Parseador.new.parsear_registro(argumentos, id)

    expect(datos.nombre).to eq nombre
    expect(datos.email).to eq email
    expect(datos.id).to eq id
  end

  it 'parsear_registro levanta ErrorParseo cuando hay menos de dos argumentos' do
    nombre = 'juan'
    id = 5
    argumentos = nombre.to_s

    expect  do
      Parseador.new.parsear_registro(argumentos, id)
    end.to raise_error(ErrorParseo)
  end

  it 'parsear_registro levanta ErrorParseo cuando hay mas de dos argumentos' do
    nombre = 'juan'
    email = 'juan@mail.com'
    fecha = '12-12-12'
    id = 5
    argumentos = "#{nombre},#{email},#{fecha}"

    expect  do
      Parseador.new.parsear_registro(argumentos, id)
    end.to raise_error(ErrorParseo)
  end

  it 'parsear_registro levanta ErrorParseo cuando hay argumentos es nil' do
    id = 5
    argumentos = nil

    expect  do
      Parseador.new.parsear_registro(argumentos, id)
    end.to raise_error(ErrorParseo)
  end

  it 'parsear_ingresar_auto devuelve un DatosAuto con los datos parseados' do
    patente = 'ABC123'
    modelo = 'Fiat Uno'
    kilometros = 500
    anio = 1990
    id = 123
    argumentos = "#{patente},#{modelo},#{kilometros},#{anio}"
    esperado = DatosAuto.new(patente, modelo, kilometros, anio, id)

    datos = Parseador.new.parsear_ingresar_auto(argumentos, id)

    expect(datos).to eq(esperado)
  end

  it 'parsear_ingresar_auto levanta ErrorParseo cuando hay menos de cuatro argumentos' do
    patente = 'ABC123'
    id = 123
    argumentos = patente.to_s

    expect  do
      Parseador.new.parsear_ingresar_auto(argumentos, id)
    end.to raise_error(ErrorParseo)
  end

  it 'parsear_ingresar_auto levanta ErrorParseo cuando hay mas de cuatro argumentos' do
    patente = 'ABC123'
    modelo = 'Fiat Uno'
    kilometros = 500
    anio = 1990
    precio = '25000'
    id = 5
    argumentos = "#{patente},#{modelo},#{kilometros},#{anio},#{precio}"

    expect  do
      Parseador.new.parsear_registro(argumentos, id)
    end.to raise_error(ErrorParseo)
  end

  it 'parsear_ingresar_auto levanta ErrorParseo cuando hay argumentos es nil' do
    id = 5
    argumentos = nil

    expect  do
      Parseador.new.parsear_ingresar_auto(argumentos, id)
    end.to raise_error(ErrorParseo)
  end

  it 'parsear_vender_a_fiubak devuelve un DatosVentaFiubak con los datos parseados' do
    patente = 'ABC123'
    id = 123
    argumentos = patente.to_s
    esperado = DatosCompraVentaFiubak.new(patente, id)

    datos = Parseador.new.parsear_compraventa_a_fiubak(argumentos, id)

    expect(datos).to eq(esperado)
  end

  it 'parsear_vender_a_fiubak levanta ErrorParseo cuando hay argumentos es nil' do
    id = 5
    argumentos = nil

    expect  do
      Parseador.new.parsear_compraventa_a_fiubak(argumentos, id)
    end.to raise_error(ErrorParseo)
  end

  it 'parsear_vender_a_fiubak levanta ErrorParseo cuando hay mas de un argumento' do
    patente = 'ABC123'
    modelo = 'Fiat Uno'
    id = 5
    argumentos = "#{patente},#{modelo}"

    expect  do
      Parseador.new.parsear_compraventa_a_fiubak(argumentos, id)
    end.to raise_error(ErrorParseo)
  end

  it 'parsear_publicar_p2p devuelve un DatosPublicarP2P con los datos parseados' do
    patente = 'ABC123'
    id = 123
    precio = 1000
    argumentos = "#{patente},#{precio}"
    esperado = DatosPublicarP2P.new(patente, id, precio)

    datos = Parseador.new.parsear_publicar_p2p(argumentos, id)

    expect(datos).to eq(esperado)
  end

  it 'parsear_publicar_p2p levanta ErrorParseo cuando la cantidad de argumentos es distinta de 2' do
    patente = 'ABC123'
    id = 123
    argumentos = patente.to_s

    expect  do
      Parseador.new.parsear_publicar_p2p(argumentos, id)
    end.to raise_error(ErrorParseo)
  end

  it 'parsear_publicar_p2p levanta ErrorParseo cuando no hay argumentos' do
    id = 123
    argumentos = nil

    expect  do
      Parseador.new.parsear_publicar_p2p(argumentos, id)
    end.to raise_error(ErrorParseo)
  end

  it 'parsear_realizar_oferta devuelve un DatosRealizarOferta con los datos parseados' do
    patente = 'ABC123'
    id_ofertante = 123
    precio = 1000
    argumentos = "#{patente},#{precio}"
    esperado = DatosRealizarOferta.new(id_ofertante, patente, precio)

    datos = Parseador.new.parsear_realizar_oferta(argumentos, id_ofertante)

    expect(datos).to eq(esperado)
  end

  it 'parsear_realizar_oferta levanta ErrorParseo cuando la cantidad de argumentos es distinta de 2' do
    patente = 'ABC123'
    id = 123
    argumentos = patente.to_s

    expect  do
      Parseador.new.parsear_realizar_oferta(argumentos, id)
    end.to raise_error(ErrorParseo)
  end

  it 'parsear_realizar_oferta levanta ErrorParseo cuando no hay argumentos' do
    id = 123
    argumentos = nil

    expect  do
      Parseador.new.parsear_realizar_oferta(argumentos, id)
    end.to raise_error(ErrorParseo)
  end

  it 'parsear_oferta_elegida devuelve un DatosOfertaElegida con los datos parseados' do
    id_oferta = 123
    argumentos = id_oferta.to_s
    esperado = DatosOfertaElegida.new(id_oferta)

    datos = Parseador.new.parsear_oferta_elegida(argumentos)

    expect(datos).to eq(esperado)
  end

  it 'parsear_oferta_elegida levanta ErrorParseo cuando la cantidad de argumentos es distinta de 1' do
    id_oferta = 123
    argumentos = "#{id_oferta},100"

    expect  do
      Parseador.new.parsear_oferta_elegida(argumentos)
    end.to raise_error(ErrorParseo)
  end

  it 'parsear_oferta_elegida levanta ErrorParseo cuando no hay argumentos' do
    argumentos = nil

    expect  do
      Parseador.new.parsear_oferta_elegida(argumentos)
    end.to raise_error(ErrorParseo)
  end
end
