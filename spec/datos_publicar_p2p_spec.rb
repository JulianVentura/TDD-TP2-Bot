require './app/datos/datos_publicar_p2p'

describe 'DatosPublicarP2P' do
  it 'deberian ser iguales' do
    datos1 = DatosPublicarP2P.new('ABC123', 1234, 3000)
    datos2 = DatosPublicarP2P.new('ABC123', 1234, 3000)
    expect(datos1).to eq datos2
  end
end
