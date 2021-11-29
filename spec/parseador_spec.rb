require 'spec_helper'
require './app/parseador'

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
end
