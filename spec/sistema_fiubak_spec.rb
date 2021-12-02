require './app/sistema_fiubak'
require './app/datos/datos_registro'
require './app/respuestas/respuesta_registro'
require './app/datos/datos_auto'
require './app/respuestas/respuesta_auto'
require 'spec_helper'
require 'web_mock'
require './app/errores/error_api'

describe 'SistemaFiubak' do
  let(:sistema_fiubak) { SistemaFiubak.new }
  let(:datos_registro) { DatosRegistro.new('juan', 'juan@mail.com', 123) }
  let(:datos_auto) { DatosAuto.new('Fiat Uno', 'ABC123', 10_000, 1990, 1234) }

  it 'deberia hacer post a usuarios' do
    body = {
      nombre: 'juan',
      email: 'juan@mail.com',
      id: 123
    }

    MockeadorEndpoints.new.mockear_endpoint('/usuarios', 201, body)

    res = sistema_fiubak.registrar(datos_registro)
    esperado = RespuestaRegistro.new('juan', 'juan@mail.com', 123)

    expect(res.nombre).to eq esperado.nombre
    expect(res.email).to eq esperado.email
    expect(res.id).to eq esperado.id
  end

  it 'deberia lanzar una excepcion ante un error' do
    body = {
      error: 'Error: Ya estas registrado'
    }

    MockeadorEndpoints.new.mockear_endpoint('/usuarios', 400, body)

    expect do
      sistema_fiubak.registrar(datos_registro)
    end.to raise_error(an_instance_of(ErrorApi).and(having_attributes(mensaje: 'Error: Ya estas registrado')))
  end

  it 'deberia ingresar un auto' do
    body = {
      patente: 'ABC123',
      modelo: 'Fiat Uno',
      kilometros: 10_000,
      anio: 1990,
      id_prop: 1234,
      estado: 'En revision',
      precio: 0
    }

    MockeadorEndpoints.new.mockear_endpoint('/autos', 201, body)

    res = sistema_fiubak.ingresar_auto(datos_auto)
    esperado = RespuestaAuto.new('ABC123', 'Fiat Uno', 10_000, 1990, 1234, 'En revision')
    expect(res).to eq(esperado)
  end

  it 'deberia fallar si llega un error en ingresar auto' do
    body = {
      error: 'Error: no se ingreso bien el auto'
    }

    MockeadorEndpoints.new.mockear_endpoint('/autos', 400, body)
    expect do
      sistema_fiubak.ingresar_auto(datos_auto)
    end.to raise_error(an_instance_of(ErrorApi).and(having_attributes(mensaje: 'Error: no se ingreso bien el auto')))
  end

  it 'deberia devolver una lista con mis autos' do
    auto = {
      patente: 'ABC123',
      modelo: 'Fiat Uno',
      kilometros: 10_000,
      anio: 1990,
      id_prop: 1234,
      estado: 'En revision',
      precio: 0
    }

    body = [auto]

    MockeadorEndpoints.new.mockear_get('/usuarios/1234/autos', 200, body)

    res = sistema_fiubak.consultar_mis_autos(1234)
    esperado = [RespuestaAuto.new('ABC123', 'Fiat Uno', 10_000, 1990, 1234, 'En revision')]
    expect(res).to eq(esperado)
  end

  it 'deberia devolver una lista con mis autos cotizados' do
    auto = {
      patente: 'ABC123',
      modelo: 'Fiat Uno',
      kilometros: 10_000,
      anio: 1990,
      id_prop: 1234,
      estado: 'Cotizado',
      precio: 5000
    }

    body = [auto]

    MockeadorEndpoints.new.mockear_get('/usuarios/1234/autos', 200, body)

    res = sistema_fiubak.consultar_mis_autos(1234)
    esperado = [RespuestaAutoCotizado.new('ABC123', 'Fiat Uno', 10_000, 1990, 1234, 'Cotizado', 5000)]
    expect(res).to eq(esperado)
  end

  it 'deberia fallar si llega un error en listar mis autos' do
    body = {
      error: 'Error: ocurrio un error'
    }

    MockeadorEndpoints.new.mockear_get('/usuarios/1234/autos', 400, body)

    expect do
      sistema_fiubak.consultar_mis_autos(1234)
    end.to raise_error(an_instance_of(ErrorApi).and(having_attributes(mensaje: 'Error: ocurrio un error')))
  end

  it 'deberia vender un auto a fiubak' do
    body = {
      patente: 'ABC123',
      modelo: 'Fiat Uno',
      kilometros: 10_000,
      anio: 1990,
      id_prop: 1234,
      estado: 'Esperando entrega',
      precio: 15_000
    }

    MockeadorEndpoints.new.mockear_endpoint('/autos/ABC123/vender_a_fiubak', 200, body)

    res = sistema_fiubak.vender_a_fiubak(datos_auto)
    esperado = RespuestaAutoCotizado.new('ABC123', 'Fiat Uno', 10_000, 1990, 1234, 'Esperando entrega', 15_000)
    expect(res).to eq(esperado)
  end
end
