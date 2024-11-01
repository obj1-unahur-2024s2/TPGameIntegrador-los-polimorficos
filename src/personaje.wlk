import extras.*

object coco {
  var vida = 100
  //var property arma = armaMano
  var property position = game.at(1,9)
  //[15, 9] y [15, 8] puerta de salida

  method image() = "coco1.png"


  method irA(nuevaPosicion) {
		position = nuevaPosicion
	}

  method recibirAtaque(ataque){
    vida = 0.min(vida - ataque)
  }

  //method ponerArma(armaAPoner) {
    //arma = armaAPoner
  //}
  //method rotarArma() {
  //  arma = arma.siguiente()
  //}

  method atacar() {
    
  }

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


//object armaMano {
 // method siguiente() = armaDistancia
 // method image() = "armaDistancia.png" //tengo imagenes del personaje con distintas armas
  //var property position = game.colliders(coco)
//}
//object armaDistancia {
 // method siguiente() = armaMano
 // method image() = "armaMano.png"
  //var property position = game.colliders(coco)
//}