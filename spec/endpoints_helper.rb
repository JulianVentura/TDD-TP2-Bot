def registrar_url
  '/usuarios'
end

def ingresar_auto_url
  '/autos'
end

def consultar_mis_autos_url(id_usuario)
  "/usuarios/#{id_usuario}/autos"
end

def vender_a_fiubak_url(patente)
  "/autos/#{patente}/vender_a_fiubak"
end

def publicar_p2p_url(patente)
  "/autos/#{patente}/publicar_p2p"
end

def realizar_oferta_url(patente)
  "/autos/#{patente}/realizar_oferta"
end

def rechazar_oferta_url(id_oferta)
  "/ofertas/#{id_oferta}/rechazar"
end

def listar_autos_url
  '/autos'
end

def comprar_a_fiubak_url(patente)
  "/autos/#{patente}/comprar"
end

def consultar_ofertas_recibidas_url(patente)
  "/autos/#{patente}/ofertas"
end

def consultar_ofertas_realizadas_url(id_usuario)
  "/usuarios/#{id_usuario}/ofertas"
end
