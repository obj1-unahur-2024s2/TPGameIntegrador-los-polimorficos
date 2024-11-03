import personaje.*
import game.*
class Monstruo{
    var vida = 100
    var property estaVivo = true
    var property fuerza = 999
    var property position = game.at(x, y)
    const x = (0.. game.width()-1).anyOne()
    const y = (0.. game.height()-1).anyOne()
    var dir = "Izq"
    var pos = 1

    method image() = "slayerCamina" + dir + pos + ".png"

    method perseguirPersonaje(){
        if (self.position() != coco.position())
            position = self.perseguirEnDireccionY()
            position = self.perseguirEnDireccionX()
            game.onTick(300, "animacionDelCanibal", {self.animacionCaminar()})
            if (self.perseguirEnDireccionX() == position.right(1))
                dir = "Der"
            else
                dir = "Izq"
    }

    method animacionCaminar(){
        pos +=1
        if (pos == 5) pos = 1
        return pos
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
    method murio() = vida == 0

    method morir() {
        if(self.murio()){
         game.removeVisual(self)
        }
    }

    method recibirAtaque(potencia) {vida -= (coco.arma().poderDeDanio() + potencia) / 2}
    method atacar() {game.whenCollideDo(coco, {jugador => self.atacarJugador(jugador)})}
    method atacarJugador(jugador) {jugador.recibirAtaque(fuerza)}
}
