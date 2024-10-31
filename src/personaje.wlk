object coco {
  var vida = 100
  var property position = game.at(1,9)
  //[15, 9] y [15, 8] puerta de salida

  method image() = "coco1.png"

  method recibirAtaque(ataque){
    vida = 0.min(vida - ataque)
  }

  method curarVida(){
    vida = 100.max(vida + 25)
  }

  method  murio() = vida == 0
}