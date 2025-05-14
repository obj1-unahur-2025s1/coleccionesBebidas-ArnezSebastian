object tito {
    var cantidad = 0
    var bebida = null
    method peso() = 70
    method inerciaBase() = 490
    method consumir(unaCantidad,unaBebida) {
        bebida = unaBebida
        cantidad = unaCantidad
    }
    method bebida() = bebida

    method velocidad() {
        return bebida.rendimiento(cantidad)
        * self.inerciaBase() / self.peso() //siempre da 7 (490 dividido 70).
    }
}

object whisky {
    method rendimiento(cantidad) = 0.9 ** cantidad
}
object cianuro {
    method rendimiento(cantidad) = 0
}

object terere {
  /*
    method rendimiento(cantidad) {
        return 1.max(cantidad * 0.1)
        //tambien (cantidad * 0.1).max(1)
    }
  */
  method rendimiento(cantidad) = 1.max(cantidad * 0.1)
}

object licuado {
    const nutrientes = []
    method agregar(cantidad) {
        nutrientes.add(cantidad)
    }
    /*
    method rendimiento(cantidad) {
        return nutrientes.sum() * cantidad
    }
    */
    method rendimiento(cantidad) = nutrientes.sum() * cantidad
    method nutrientes() = nutrientes
}


object aguaSaborizada {
    var bebida = terere
    /*
    method rendimiento(cantidad) {
        return 1 + bebida.rendimiento(cantidad)
    }
    */
    //method rendimiento(cantidad) = 1 + bebida.rendimiento(cantidad)
    method rendimiento(cantidad) = agua.rendimiento(cantidad) + bebida.rendimiento(cantidad)
    method saborizarDe(nuevaBebida) {
        bebida = nuevaBebida
    }
}

object agua {
  method rendimiento(cantidad) = 1 
}

/*
    Cambios realizados a la consigna:
      Coctel: está compuesto por una serie de bebidas, todas en la misma proporción. El 
      rendimiento es el producto de los rendimientos de las bebidas que lo componen. Por 
      ejemplo, si hubiera cianuro en el coctel su rendimento va a ser 0 sin importar las 
      otras bebidas.
      Coctel suave: está compuesto por una serie de bebidas. El rendimiento es la suma de los 
      rendimientos de las bebidas que tengan un rendimiento mayor a 0.5.

    El requerimiento es el mismo que en la primera parte, hacer que Tito tome cierta cantidad de 
    una bebida y pueda responder su velocidad. Para pensar:
      ¿Si se le agregan nuevos ingredientes al licuado luego que forme parte del coctel, afecta 
      al rendimiento que otorta el coctel?
      ¿Puede el coctel incluir a la vez whisky y agua saborizada con whisky?
      ¿Puede el coctel incluir el agua saborizada con coctel?
*/

object coctelSuave {
  const bebidas = [whisky , terere]
  /*
  method rendimiento(cantidad) {
    bebidas.remove({bebida => bebida.rendimiento(cantidad)})
    return bebidas.sum(bebidas.rendimiento())
  }
  */
  method rendimiento(cantidad) {
    const bebidasAConsiderar = bebidas.filter({bebida=> bebida.rendimiento(cantidad) > 0.5}) //filtra las bebidas según el rendimiento que tengan, el cual, no debe ser menor a 0.5
    return bebidasAConsiderar.sum({bebida => bebida.rendimiento(cantidad)}) //hace la sumatoria del rendimiento de cada bebida según la cantidad que se indicó en el rendimiento general.
  }
  method agregarBebida(nuevaBebida) {
    bebidas.add(nuevaBebida)
  }
  method sacarBebida(bebidaIndicada) {
    bebidas.remove(bebidaIndicada) //si el remove no encuentra un valor, no lo saca, osease, no tira error
  }
  method bebidas() = bebidas
  method cantidadDeBebidas() = bebidas.size()
}

object coctel {
  const bebidas = [whisky, terere]
  method bebidas() = bebidas
  method cantidadDeBebidas() = bebidas.size()
  method agregarBebida(nuevaBebida) {
    bebidas.add(nuevaBebida)
  }
  method sacarBebida(bebidaIndicada) {
    bebidas.remove(bebidaIndicada)
  }
  method rendimiento(cantidad) {
    var rend = 1 // Se crea el rendimiento inicial del coctel, el cual va a cambiar al de la bebida que se este analizando luego, ápara eso se elije el 1.
    bebidas.forEach({bebida => rend = rend * bebida.rendimiento(cantidad)})  // Cada bebida de la lista de bebidas se multiplica por el rendimiento actual.
    return rend //se retorna el rendimiento actual.
  }
}