import extras.*

object coco {
  var vida = 100
  var property arma = armaMano
  var property position = game.at(1,9)
  //[15, 9] y [15, 8] puerta de salida
  var mov = 0

  method image() = "cocoEspada" + mov +".png"

  method atacar() {
    game.onTick(250, "movimientos", {self.movimiento()})
  }

  method movimiento() {
    mov += 1
    if(mov == 7){mov = 1}
    return mov
  }

  method irA(nuevaPosicion) {position = nuevaPosicion}

  method recibirAtaque(ataque){vida = 0.min(vida - ataque)}

  //method ponerArma(armaAPoner) {
    //arma = armaAPoner
  //}
  //method rotarArma() {
  //  arma = arma.siguiente()
  //}

  method curarVida(){
    vida = 100.max(vida + 25)
  }

  method murio() = vida == 0

  method morir() {
    if(self.murio()){
      game.removeVisual(self)
    }
  }
}


object armaMano {
//  method siguiente() = armaDistancia
 method image() = "armaDistancia.png" //tengo imagenes del personaje con distintas armas
  var property position = game.colliders(coco)
}
//object armaDistancia {
 // method siguiente() = armaMano
 // method image() = "armaMano.png"
  //var property position = game.colliders(coco)
//}