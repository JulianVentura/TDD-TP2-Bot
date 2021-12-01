describe 'RespuestaAuto' do
  it 'deberian ser iguales' do
    respuesta1 = RespuestaAuto.new('ABC123', 'Fiat Uno', 10_000, 1990, 1234, 'En revision')
    respuesta2 = RespuestaAuto.new('ABC123', 'Fiat Uno', 10_000, 1990, 1234, 'En revision')
    expect(respuesta1).to eq respuesta2
  end
end
