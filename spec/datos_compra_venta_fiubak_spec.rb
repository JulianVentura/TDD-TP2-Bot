require './app/datos/datos_compra_venta_fiubak'
describe 'DatosVentaFiubak' do
  it 'deberian ser iguales' do
    datos1 = DatosCompraVentaFiubak.new('ABC123', 1234)
    datos2 = DatosCompraVentaFiubak.new('ABC123', 1234)
    expect(datos1).to eq datos2
  end
end
