require './app/respuestas/respuesta_realizar_oferta'
describe 'RespuestaRealizarOferta' do
  it 'deberian ser iguales' do
    respuesta1 = RespuestaRealizarOferta.new('ABC123')
    respuesta2 = RespuestaRealizarOferta.new('ABC123')
    expect(respuesta1).to eq respuesta2
  end
end
