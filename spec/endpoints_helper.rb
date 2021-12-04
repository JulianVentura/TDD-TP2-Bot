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

def listar_autos_url
  '/autos'
end

def comprar_a_fiubak_url(patente)
  "/autos/#{patente}/comprar"
end
