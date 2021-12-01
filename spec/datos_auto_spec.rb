describe 'DatosAuto' do
  it 'deberian ser iguales' do
    datos1 = DatosAuto.new('ABC123', 'Fiat Uno', 10_000, 1990, 1234)
    datos2 = DatosAuto.new('ABC123', 'Fiat Uno', 10_000, 1990, 1234)
    expect(datos1).to eq datos2
  end
end
