import extras.*

object coco {
  var vidas = 2
  method vidas() = vidas 
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

  method posicionInicial(numeroNivel){
    if (numeroNivel == 1)
      position = game.at(3, 3)
    else
      position = game.at(3, 7)
  }

  method perderVida() {
    vidas -= 0.01
    Vidas.perderVida()
  }
  method estaVivo() = vidas > 0

  method recuperarVida() {
    const vidaFaltante = 3-vidas
    vidas += vidaFaltante
    
  }
}
class Vidas{
  var property position = game.at(x, y)
  var x
  var y
  var imagen = "corazon.png"

  method image() = imagen

  method perderVida(){
    imagen = "corazonMuerto.png"
  }

  method recuperarVida(){
    imagen = "corazon.png"
  }
}