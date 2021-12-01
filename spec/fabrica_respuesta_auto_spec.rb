require './app/respuestas/fabrica_respuesta_auto'

describe 'FabricaRespuestaAuto' do
  let(:fabrica) { FabricaRespuestaAuto.new }

  it 'deberia dar una RespuestaAuto si el estado es "En revision"' do
    respuesta_auto = fabrica.crear('ABC123', 'Fiat Uno', 10_000, 1990, 1234, 'En revision')
    esperado = RespuestaAuto.new('ABC123', 'Fiat Uno', 10_000, 1990, 1234, 'En revision')
    expect(respuesta_auto).to eq esperado
  end

  it 'deberia dar una RespuestaAutoCotizado si el estado es "Cotizado"' do
    respuesta_auto = fabrica.crear('ABC123', 'Fiat Uno', 10_000, 1990, 1234, 'Cotizado', 5000)
    esperado = RespuestaAutoCotizado.new('ABC123', 'Fiat Uno', 10_000, 1990, 1234, 'Cotizado', 5000)
    expect(respuesta_auto).to eq esperado
  end
end
