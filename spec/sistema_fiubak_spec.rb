require './app/sistema_fiubak'
require './app/respuestas/respuesta_registro'
require 'spec_helper'
require 'web_mock'
require 'byebug'

describe 'SistemaFiubak' do
  let(:sistema_fiubak) { SistemaFiubak.new }

  it 'deberia hacer post a usuarios' do
    MockeadorEndpoints.new.mockear_endpoint('/usuarios', 201,
                                            nombre: 'juan',
                                            email: 'juan@mail.com',
                                            id: 123)

    # stub_request(:post, 'http://webapp:3000/usuarios')
    #  .with(headers: { 'Content-Type' => 'application/json' })
    #  .to_return(status: 201, body: { nombre: 'juan', email: 'juan@mail.com', id: 123 }.to_json)
    res = sistema_fiubak.registrar('juan', 'juan@mail.com', 123)
    esperado = RespuestaRegistro.new('juan', 'juan@mail.com', 123)

    expect(res.nombre).to eq esperado.nombre
    expect(res.email).to eq esperado.email
    expect(res.id).to eq esperado.id
  end
end
