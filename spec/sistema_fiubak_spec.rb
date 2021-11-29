require './app/sistema_fiubak'
require './app/respuestas/respuesta_registro'
require 'spec_helper'
require 'web_mock'
require './app/error_api'
require 'byebug'

describe 'SistemaFiubak' do
  let(:sistema_fiubak) { SistemaFiubak.new }

  it 'deberia hacer post a usuarios' do
    body = {
      nombre: 'juan',
      email: 'juan@mail.com',
      id: 123
    }

    MockeadorEndpoints.new.mockear_endpoint('/usuarios', 201, body)

    res = sistema_fiubak.registrar('juan', 'juan@mail.com', 123)
    esperado = RespuestaRegistro.new('juan', 'juan@mail.com', 123)

    expect(res.nombre).to eq esperado.nombre
    expect(res.email).to eq esperado.email
    expect(res.id).to eq esperado.id
  end

  it 'deberia lanzar una excepcion ante un error' do
    body = {
      error: 'Error: Ya estas registrado'
    }

    MockeadorEndpoints.new.mockear_endpoint('/usuarios', 400, body)

    expect do
      sistema_fiubak.registrar('juan', 'juan@mail.com', 123)
    end.to raise_error(an_instance_of(ErrorApi).and(having_attributes(mensaje: 'Error: Ya estas registrado')))
  end
end
