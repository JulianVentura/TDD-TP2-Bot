require './app/datos/datos_realizar_oferta'

describe 'DatosRealizarOferta' do
  it 'deberian ser iguales' do
    datos1 = DatosRealizarOferta.new('ABC123', 1234, 3000)
    datos2 = DatosRealizarOferta.new('ABC123', 1234, 3000)
    expect(datos1).to eq datos2
  end
end
