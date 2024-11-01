import personaje.*
import game.*
class Monstruo{
    var vida = 100
    var property estaVivo = true
    var property fuerza = 10
    var property position = game.at(x, y)
    const x = (0.. game.width()-1).anyOne()
    const y = (0.. game.height()-1).anyOne()
    var imagen = "monstruo.png"
    var pos = 0

    method image() = imagen
    method vida() = vida

    method perseguirPersonaje(){
        const caminarDer = ["slayerCaminaDer1.png", "slayerCaminaDer2.png", "slayerCaminaDer3.png", "slayerCaminaDer4.png","slayerCaminaDer1.png"]
        const caminarIzq = ["slayerCaminaIzq1.png", "slayerCaminaIzq2.png", "slayerCaminaIzq3.png", "slayerCaminaIzq4.png", "slayerCaminaIzq1.png"]
        if (self.position() != coco.position())
            position = self.perseguirEnDireccionY()
            position = self.perseguirEnDireccionX()
            if (self.perseguirEnDireccionX() == position.right(1))
                game.onTick(900, "animacionDelCanibal", {imagen = self.animacionCaminar(caminarDer)})
            else
                game.onTick(900, "animacionDelCanibal", {imagen = self.animacionCaminar(caminarIzq)})
    }

    method animacionCaminar(listaAnimacion){
        pos +=1
        if (pos == 5) pos = 0
        return listaAnimacion.get(pos)
    }

    method perseguirEnDireccionX(){
        var mover = position
        if(coco.position().x() > self.position().x())
            mover = mover.right(1)
        else if(coco.position().x() < self.position().x()) 
            mover = mover.left(1)
        return mover
    } 

    method perseguirEnDireccionY(){
        var mover = position
        if(coco.position().y() > self.position().y())
            mover = mover.up(1)
        else if(coco.position().y() < self.position().y()) 
            mover = mover.down(1)
        return mover
    }    

    //method recibirAtaque(ataque){
    //    if (coco.arma() == armaMano) {
    //        vida = 0.min(vida - (ataque / 2))
    //    }
    //    else {
    //        vida = 0.min(vida - ataque)
    //    }
    //}

   method atacar() {
     game.whenCollideDo(self, {jugador => self.atacarJugador(jugador)})
    }

   method atacarJugador(jugador) {
     jugador.recibirAtaque(fuerza)
   }
}
