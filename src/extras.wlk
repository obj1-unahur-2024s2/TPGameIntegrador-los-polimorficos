import personaje.*
import game.*
class Monstruo{
    var vida = 2
    var property position = game.at(x, y)
    const x = (3.. game.width()-6).anyOne()
    const y = (3.. game.height()-6).anyOne()
    var dir = "Izq"
    var pos = 1

    method image() = if(!self.estaMuerto())"slayerCamina" + dir + pos + ".png" else "corazonMuerto.png"

    method perseguirACoco(velocidad, id, mapaNivel){
        game.onTick(velocidad, "perseguirCoco" + id, {self.perseguirPersonaje(mapaNivel)})
    }

    method morir(id) {
      if(self.estaMuerto()){
        game.removeVisual(self)
        game.removeTickEvent("perseguirCoco" + id)
      }
    }

    method perseguirPersonaje(mapaNivel){
        if (self.position() != coco.position())
            position = self.perseguirEnDireccionY(mapaNivel)
            position = self.perseguirEnDireccionX(mapaNivel)
            game.onTick(1000, "animacionDelCanibal", {self.animacionCaminar()})
            if (self.perseguirEnDireccionX(mapaNivel) == position.right(1))
                dir = "Der"
            else
                dir = "Izq"
    }

    method animacionCaminar(){
        pos +=1
        if (pos == 5) pos = 1
        return pos
    }

    method perseguirEnDireccionX(mapaNivel){
        var mover = position
        if(coco.position().x() > self.position().x())
            mover = mover.right(1)
        else if(coco.position().x() < self.position().x()) 
            mover = mover.left(1)
        return mover
    } 

    method perseguirEnDireccionY(mapaNivel){
        var mover = position
        if(coco.position().y() > self.position().y()) 
            mover = mover.up(1)
        else if(coco.position().y() < self.position().y())
            mover = mover.down(1)
        return mover
    }    
    method estaMuerto() = vida == 0

    method recibirAtaque(id){
        vida = 0.max(vida - 0.5)
        if (self.estaMuerto())
            self.morir(id)
    }
}

class Calabera inherits Monstruo(vida = 2.5){
    var direccion = 0
    var miraA = "Der"
    override method image() = "calabera" + miraA + ".png"

    override method perseguirACoco(velocidad, id, mapaNivel){
        game.onTick(velocidad, "perseguirCoco" + id, {self.perseguirPersonaje(mapaNivel)})
    }

    override method perseguirPersonaje(mapaNivel){
        game.onTick(250, "cambiarDir", {self.cambiarDireccion(mapaNivel)})
        self.cambiarDireccion(mapaNivel)
        if(direccion == 0)
            position = position.up(1)
        else if(direccion == 1)
            position = position.right(1)
        else if(direccion == 2)
            position = position.down(1)
        else
            position = position.left(1)
        
    }

    method puedeMoverHacia(mapaNivel){
        const positionX = self.position().x()
        const positionY = self.position().y()
        return (mapaNivel.bloquesMapa().murosNivel().any({muro => muro.get(0) == positionX and muro.get(1) == positionY})) or (positionY == 12) or (positionY == 2) or (positionX == 3)
    }
    method cambiarDireccion(mapaNivel){
        const positionX = self.position().x()
        const positionY = self.position().y()
        
        if(direccion == 4)
            direccion = 0
        else if(positionY > 11)
            direccion = 2
        else if(positionY < 3)
            direccion = 0
        else if(positionX < 3)
            direccion = 1
        else if(positionX > 12)
            direccion = 3
        else{direccion += 1}
    }

    override method recibirAtaque(id){
        vida = 0.max(vida - 0.9)
        if (self.estaMuerto())
            self.morir(id)
    }
}

class Vidas{
  var property position = game.at(x, y)
  var property x
  var property y
  var imagen = "corazon.png"

  method image() = imagen

  method perderVida(){
    imagen = "corazonMuerto.png"
  }

  method recuperarVida(){
    imagen = "corazon.png"
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
    var property image = "mapaFinal.png" //proximamente
}

object imagenDeVictoria{
    var property position = game.center()
    var property image = "fondoVictoria.png" //proximamente
}

object imagenGameOver{
    var property position = game.center()
    var property image = "fondoGameOver.png" //proximamente
}


class Pociones {
  
    var property position = game.at(x, y)
    var x
    var y 
    const imagen = "pocionCorazon.png"
    var property vida = 1

    method image() = imagen

    method curar() {
        if(coco.vidas() < 3 and vida > 0){
            coco.recuperarVida()
            vida -= 1
            self.desaparecer()
            game.sound("tomarPocion.mp3").play()
        }
    
    }

    method desaparecer() {
        if (self.estaUsada()){
            game.removeVisual(self)
        }
    
    }

    method estaUsada() = vida ==0
}