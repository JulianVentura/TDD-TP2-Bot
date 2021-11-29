require 'spec_helper'
require './app/parseador'
require './app/error_parseo'

describe 'Parseador' do
  it 'parsear_registro devuelve un RegistroDatos con los datos parseados' do
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
end
