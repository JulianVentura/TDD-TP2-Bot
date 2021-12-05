require './app/datos/datos_consultar_ofertas_realizadas'
describe 'DatosConsultarOfertasRealizadas' do
  it 'deberian ser iguales' do
    id = 123
    datos1 = DatosConsultarOfertasRealizadas.new(id)
    datos2 = DatosConsultarOfertasRealizadas.new(id)
    expect(datos1).to eq datos2
  end
end
