require './app/respuestas/respuesta_auto_cotizado'
describe 'RespuestaAutoCotizado' do
  it 'deberian ser iguales' do
    respuesta1 = RespuestaAutoCotizado.new('ABC123', 'Fiat Uno', 10_000, 1990, 1234, 'Cotizado', 5000)
    respuesta2 = RespuestaAutoCotizado.new('ABC123', 'Fiat Uno', 10_000, 1990, 1234, 'Cotizado', 5000)
    expect(respuesta1).to eq respuesta2
  end
end
