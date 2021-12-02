describe 'DatosVentaFiubak' do
  it 'deberian ser iguales' do
    datos1 = DatosVentaFiubak.new('ABC123', 1234)
    datos2 = DatosVentaFiubak.new('ABC123', 1234)
    expect(datos1).to eq datos2
  end
end
