import extras.*

object coco {
  var vidas = 3
  var property arma = armaMano
  var property position = game.at(1,9)
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

  method perderVida() {
    vidas -= 1
  }

  method estaVivo() = vidas > 0
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