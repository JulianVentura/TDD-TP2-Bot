require './app/datos/datos_oferta_elegida'
describe 'DatosOfertaElegida' do
  it 'deberian ser iguales' do
    datos1 = DatosOfertaElegida.new(123, 1234)
    datos2 = DatosOfertaElegida.new(123, 1234)
    expect(datos1).to eq datos2
  end
end
