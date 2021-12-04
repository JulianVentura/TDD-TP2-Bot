require './app/sistema_fiubak'
require './app/datos/datos_registro'
require './app/respuestas/respuesta_registro'
require './app/datos/datos_auto'
require './app/respuestas/respuesta_auto'
require 'spec_helper'
require 'endpoints_helper'
require 'web_mock'
require './app/errores/error_api'

describe 'SistemaFiubak' do
  let(:sistema_fiubak) { SistemaFiubak.new }
  let(:datos_registro) { DatosRegistro.new('juan', 'juan@mail.com', 123) }
  let(:datos_auto) { DatosAuto.new('Fiat Uno', 'ABC123', 10_000, 1990, 1234) }
  let(:datos_p2p) { DatosPublicarP2P.new('ABC123', 1234, 30_000) }
  let(:datos_compraventa_fiubak) { DatosCompraVentaFiubak.new('ABC123', 1234) }
  let(:datos_realizar_oferta) { DatosRealizarOferta.new('ABC123', 1234, 30_000) }

  context('when registrar') do
    it 'deberia registrar un usuario' do
      body = {
        nombre: 'juan',
        email: 'juan@mail.com',
        id: 123
      }

      MockeadorEndpoints.new.mockear_post(registrar_url, 201, body)

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

      MockeadorEndpoints.new.mockear_post(registrar_url, 400, body)

      expect do
        sistema_fiubak.registrar(datos_registro)
      end.to raise_error(an_instance_of(ErrorApi).and(having_attributes(mensaje: 'Error: Ya estas registrado')))
    end
  end

  context('when ingresar_auto') do
    it 'deberia ingresar un auto' do
      body = {
        patente: 'ABC123',
        modelo: 'Fiat Uno',
        kilometros: 10_000,
        anio: 1990,
        id_prop: 1234,
        estado: 'En revision',
        precio: 0,
        es_fiubak: false
      }

      MockeadorEndpoints.new.mockear_post(ingresar_auto_url, 201, body)

      res = sistema_fiubak.ingresar_auto(datos_auto)
      esperado = FabricaRespuestaAuto.new.crear('ABC123', 'Fiat Uno', 10_000, 1990, 1234, 'En revision', false)
      expect(res).to eq(esperado)
    end

    it 'deberia fallar si llega un error en ingresar auto' do
      body = {
        error: 'Error: no se ingreso bien el auto'
      }

      MockeadorEndpoints.new.mockear_post(ingresar_auto_url, 400, body)
      expect do
        sistema_fiubak.ingresar_auto(datos_auto)
      end.to raise_error(an_instance_of(ErrorApi).and(having_attributes(mensaje: 'Error: no se ingreso bien el auto')))
    end
  end

  context('when consultar_mis_autos') do
    it 'deberia devolver una lista con mis autos' do
      auto = {
        patente: 'ABC123',
        modelo: 'Fiat Uno',
        kilometros: 10_000,
        anio: 1990,
        id_prop: 1234,
        estado: 'En revision',
        precio: 0,
        es_fiubak: false
      }

      body = [auto]

      MockeadorEndpoints.new.mockear_get(consultar_mis_autos_url(1234), 200, body)

      res = sistema_fiubak.consultar_mis_autos(1234)
      esperado = [FabricaRespuestaAuto.new.crear('ABC123', 'Fiat Uno', 10_000, 1990, 1234, 'En revision', false)]
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
        precio: 5000,
        es_fiubak: false
      }

      body = [auto]

      MockeadorEndpoints.new.mockear_get(consultar_mis_autos_url(1234), 200, body)

      res = sistema_fiubak.consultar_mis_autos(1234)
      esperado = [FabricaRespuestaAuto.new.crear('ABC123', 'Fiat Uno', 10_000, 1990, 1234, 'Cotizado', false, 5000)]
      expect(res).to eq(esperado)
    end

    it 'deberia fallar si llega un error en listar mis autos' do
      body = {
        error: 'Error: ocurrio un error'
      }

      MockeadorEndpoints.new.mockear_get(consultar_mis_autos_url(1234), 400, body)

      expect do
        sistema_fiubak.consultar_mis_autos(1234)
      end.to raise_error(an_instance_of(ErrorApi).and(having_attributes(mensaje: 'Error: ocurrio un error')))
    end
  end

  context('when vender_a_fiubak') do
    it 'deberia vender un auto a fiubak' do
      body = {
        patente: 'ABC123',
        modelo: 'Fiat Uno',
        kilometros: 10_000,
        anio: 1990,
        id_prop: 1234,
        estado: 'Esperando entrega',
        precio: 15_000,
        es_fiubak: false
      }

      MockeadorEndpoints.new.mockear_post(vender_a_fiubak_url('ABC123'), 200, body)

      res = sistema_fiubak.vender_a_fiubak(datos_compraventa_fiubak)
      esperado = FabricaRespuestaAuto.new.crear('ABC123', 'Fiat Uno', 10_000, 1990, 1234, 'Esperando entrega', false, 15_000)
      expect(res).to eq(esperado)
    end

    it 'deberia fallar si llega un error en vender un auto a fiubak' do
      body = {
        error: 'Error: ocurrio un error'
      }

      MockeadorEndpoints.new.mockear_post(vender_a_fiubak_url('ABC123'), 400, body)

      expect do
        sistema_fiubak.vender_a_fiubak(datos_auto)
      end.to raise_error(an_instance_of(ErrorApi).and(having_attributes(mensaje: 'Error: ocurrio un error')))
    end
  end

  context('when listar_autos') do
    it 'deberia listar autos disponibles para comprar' do
      auto = {
        patente: 'ABC123',
        modelo: 'Fiat Uno',
        kilometros: 10_000,
        anio: 1990,
        id_prop: 1234,
        estado: 'Publicado',
        precio: 15_000,
        es_fiubak: true
      }

      body = [auto]

      MockeadorEndpoints.new.mockear_get(listar_autos_url, 200, body)

      res = sistema_fiubak.listar_autos
      esperado = [FabricaRespuestaAuto.new.crear('ABC123', 'Fiat Uno', 10_000, 1990, 1234, 'Publicado', true, 15_000)]
      expect(res).to eq(esperado)
    end

    it 'deberia devolver lista vacia si no hay autos disponibles para comprar' do
      body = []

      MockeadorEndpoints.new.mockear_get(listar_autos_url, 200, body)

      res = sistema_fiubak.listar_autos
      esperado = []
      expect(res).to eq(esperado)
    end

    it 'deberia fallar si llega un error en listar autos' do
      body = {
        error: 'Error: ocurrio un error'
      }

      MockeadorEndpoints.new.mockear_get(listar_autos_url, 400, body)

      expect do
        sistema_fiubak.listar_autos
      end.to raise_error(an_instance_of(ErrorApi).and(having_attributes(mensaje: 'Error: ocurrio un error')))
    end
  end

  context('when publicar_p2p') do
    it 'deberia publicar un auto p2p' do
      body = {
        patente: 'ABC123',
        modelo: 'Fiat Uno',
        kilometros: 10_000,
        anio: 1990,
        id_prop: 1234,
        estado: 'Publicado',
        precio: 30_000,
        es_fiubak: false
      }

      MockeadorEndpoints.new.mockear_post(publicar_p2p_url('ABC123'), 200, body)

      res = sistema_fiubak.publicar_p2p(datos_p2p)
      esperado = FabricaRespuestaAuto.new.crear('ABC123', 'Fiat Uno', 10_000, 1990, 1234, 'Publicado', false, 30_000)
      expect(res).to eq(esperado)
    end

    it 'deberia fallar si llega un error en publicar un auto p2p' do
      body = {
        error: 'Error: ocurrio un error'
      }

      MockeadorEndpoints.new.mockear_post(publicar_p2p_url('ABC123'), 400, body)

      expect do
        sistema_fiubak.publicar_p2p(datos_p2p)
      end.to raise_error(an_instance_of(ErrorApi).and(having_attributes(mensaje: 'Error: ocurrio un error')))
    end
  end

  context('when comprar') do
    it 'deberia comprar un auto a fiubak' do
      body = {
        patente: 'ABC123',
        modelo: 'Fiat Uno',
        kilometros: 10_000,
        anio: 1990,
        id_prop: 1234,
        estado: 'Vendido',
        precio: 30_000,
        es_fiubak: false
      }

      MockeadorEndpoints.new.mockear_post(comprar_a_fiubak_url('ABC123'), 200, body)

      res = sistema_fiubak.comprar(datos_compraventa_fiubak)
      esperado = FabricaRespuestaAuto.new.crear('ABC123', 'Fiat Uno', 10_000, 1990, 1234, 'Vendido', false, 30_000)
      expect(res).to eq(esperado)
    end

    it 'deberia fallar si llega un error en publicar un auto p2p' do
      body = {
        error: 'Error: ocurrio un error'
      }

      MockeadorEndpoints.new.mockear_post(comprar_a_fiubak_url('ABC123'), 400, body)

      expect do
        sistema_fiubak.comprar(datos_compraventa_fiubak)
      end.to raise_error(an_instance_of(ErrorApi).and(having_attributes(mensaje: 'Error: ocurrio un error')))
    end
  end

  context('when realizar_oferta') do
    it 'deberia realizar una oferta a un auto particular' do
      body = {
        id_oferta: 1,
        id_ofertante: 4567,
        patente: 'ABC123'
      }

      MockeadorEndpoints.new.mockear_post(realizar_oferta_url('ABC123'), 200, body)

      res = sistema_fiubak.realizar_oferta(datos_realizar_oferta)
      # TODO: definir que devuelve una oferta exitosa
      esperado = RespuestaRealizarOferta.new(1, 4567, 'ABC123')
      expect(res).to eq(esperado)
    end
  end
end
