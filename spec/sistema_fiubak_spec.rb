require './app/sistema_fiubak'
require './app/respuestas/respuesta_registro'
require 'web_mock'

describe 'SistemaFiubak' do
  let(:sistema_fiubak) { SistemaFiubak.new }

  it 'deberia hacer post a usuarios' do
    res = sistema_fiubak.registrar('juan', 'juan@mail.com', 123)
    esperado = RespuestaRegistro.new('juan', 'juan@mail.com', 123)

    expect(res.nombre).to eq esperado.nombre
    expect(res.email).to eq esperado.email
    expect(res.id).to eq esperado.id
  end
end
