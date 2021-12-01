require 'spec_helper'
require './app/parseador'
require './app/errores/error_parseo'
require './app/datos/datos_auto'

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
end
