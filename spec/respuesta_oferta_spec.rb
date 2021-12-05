require './app/respuestas/respuesta_oferta'
describe 'RespuestaOferta' do
  it 'deberian ser iguales' do
    id_oferta = 1
    id_ofertante = 4567
    patente = 'ABC123'
    precio = 500
    estado = 'Pendiente'
    respuesta1 = RespuestaOferta.new(id_oferta, id_ofertante, patente, precio, estado)
    respuesta2 = RespuestaOferta.new(id_oferta, id_ofertante, patente, precio, estado)
    expect(respuesta1).to eq respuesta2
  end
end
