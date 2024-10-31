import wollok.game.*
import personaje.*
import extras.*
object nivel1{
    const monstruo1 = new Monstruo()
    method iniciar(){
        game.addVisualCharacter(coco)
        game.addVisual(monstruo1)
        game.onTick(200, "perseguirPersonaje", {monstruo1.perseguirPersonaje()})
    }
    
}