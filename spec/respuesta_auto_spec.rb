describe 'RespuestaAuto' do
  it 'deberian ser iguales' do
    respuesta1 = RespuestaAuto.new('ABC123', 'Fiat Uno', 10_000, 1990, 1234, 'En revision', false)
    respuesta2 = RespuestaAuto.new('ABC123', 'Fiat Uno', 10_000, 1990, 1234, 'En revision', false)
    expect(respuesta1).to eq respuesta2
  end

  it 'no deberia estar cotizado' do
    respuesta = RespuestaAuto.new('ABC123', 'Fiat Uno', 10_000, 1990, 1234, 'En revision', false)
    expect(respuesta.esta_cotizado?).to eq false
  end
end
