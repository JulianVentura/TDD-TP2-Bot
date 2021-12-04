require './app/respuestas/respuesta_realizar_oferta'
describe 'RespuestaRealizarOferta' do
  it 'deberian ser iguales' do
    id_oferta = 1
    id_ofertante = 4567
    patente = 'ABC123'
    respuesta1 = RespuestaRealizarOferta.new(id_oferta, id_ofertante, patente)
    respuesta2 = RespuestaRealizarOferta.new(id_oferta, id_ofertante, patente)
    expect(respuesta1).to eq respuesta2
  end
end
