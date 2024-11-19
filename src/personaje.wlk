import extras.*
import niveles.*
object coco {
  var vidas = 3
  method vidas() = vidas 
  var property position = game.at(3,9)
  //[15, 9] y [15, 8] puerta de salida
  var imagen = "Espada" // para poder cambiar a animacion de movimiento
  var mov = 0

  method image() = if(self.estaVivo())"coco"+ imagen + mov +".png" else "cocoMuerto.png" 

  method atacar() {game.onTick(250, "ataque", {self.animacionEspada()})}
  method irA(nuevaPosicion) {position = nuevaPosicion}

  method animacionEspada() {
    imagen = "Espada"
    mov += 1
    if(mov == 7){
      mov = 0
      game.removeTickEvent("ataque")
    }
    return mov
  }

  method posicionInicial(numeroNivel){
    if (numeroNivel == 1)
      position = game.at(2, 5)
    else
      position = game.at(2, 8)
  }

  method perderVida() {
    vidas = 0.max(vidas - 0.25)
  }

  method estaVivo() = vidas > 0

  method recuperarVida() {
    const vidaFaltante = 3-vidas
    vidas += vidaFaltante
  }

  //ver

  method irHaciaDerecha(mapaNivel){
    if(self.estaEnMuro(mapaNivel))
      position = position.left(1)
  }

  method irHaciaIzquierda(mapaNivel){
    if(self.estaEnMuro(mapaNivel))
      position = position.right(1)
  }

  method irHaciaArriba(mapaNivel){
    if(self.estaEnMuro(mapaNivel))
      position = position.down(1)
  }

  method irHaciaAbajo(mapaNivel){
    if(self.estaEnMuro(mapaNivel))
      position = position.up(1)
  }

  method estaEnMuro(mapaNivel) = (mapaNivel.bloquesMapa().murosNivel().any({muro => muro.get(0) == self.position().x() and muro.get(1) == self.position().y()}))
  
}