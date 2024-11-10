import personaje.*
import game.*
class Monstruo{
    var vida = 3
    var property position = game.at(x, y)
    const x = (0.. game.width()-1).anyOne()
    const y = (0.. game.height()-1).anyOne()
    var dir = "Izq"
    var pos = 1

    method image() = if(vida >= 1)"slayerCamina" + dir + pos + ".png" else "corazonMuerto.png"

    method perseguirACoco(velocidad, id){
        game.onTick(velocidad, "perseguirCoco" + id, {self.perseguirPersonaje()})
    }

    method morir(id) {
      if(self.estaMuerto()){
        game.removeVisual(self)
        game.removeTickEvent("perseguirCoco" + id)
      }
    }

    method perseguirPersonaje(){
        if (self.position() != coco.position())
            position = self.perseguirEnDireccionY()
            position = self.perseguirEnDireccionX()
            game.onTick(1000, "animacionDelCanibal", {self.animacionCaminar()})
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
    method estaMuerto() = vida == 0

    method recibirAtaque(id){
        vida = 0.max(vida - 0.05)
        if (self.estaMuerto())
            self.morir(id)
    }
}

object imagenInicial{ 
    var property position = game.at(0, 0)
     var property image = "fondoInicio.png" 
     //Ahi termine de hacer la imagen base para el inicio.
     //Despues hago que aparezca al principio como pantalla de inicio, que ahora estoy cansado.
}

object fondoNivel1{
    var property position = game.center()
    var property image = "fondo1.png" 
}

object fondoNivel2{
    var property position = game.center()
    var property image = "fondo2.png" //proximamente
}

object imagenDeVictoria{
    var property position = game.center()
    var property image = "fondoVictoria.png"
}