require './app/datos/datos_consultar_ofertas_recibidas'
describe 'DatosConsultarOfertasRecibidas' do
  it 'deberian ser iguales' do
    patente = 'ABC123'
    id = 123
    datos1 = DatosConsultarOfertasRecibidas.new(patente, id)
    datos2 = DatosConsultarOfertasRecibidas.new(patente, id)
    expect(datos1).to eq datos2
  end
end
