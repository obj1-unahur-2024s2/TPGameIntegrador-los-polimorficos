import wollok.game.*
import personaje.*
import extras.*
object nivel1{
    const monstruo1 = new Monstruo()
    method iniciar(){
        game.addVisualCharacter(coco)
        game.addVisual(monstruo1)
        game.onTick(200, "perseguirPersonaje", {monstruo1.perseguirPersonaje()})
        config.configurarTeclas()
    }
    method resultado() = false
    
}
object nivel2{
    const monstruo1 = new Monstruo()
    var property resultado = false
    method iniciar(){
        game.addVisualCharacter(coco)
        game.addVisual(monstruo1)
        game.onTick(200, "perseguirPersonaje", {monstruo1.perseguirPersonaje()})
        config.configurarTeclas()
    }
    method superarNivel() {
        if (!monstruo1.estaVivo()) {
            resultado = true
        }
    }
}

object config {
    method configurarTeclas() {
        keyboard.e().onPressDo({coco.hacerDanio()})
        keyboard.r().onPressDo({coco.rotarArma()})
        keyboard.left().onPressDo({ coco.irA(coco.position().left(1))})
		keyboard.right().onPressDo({ coco.irA(coco.position().right(1))})
		keyboard.down().onPressDo({coco.irA(coco.position().down(1))})
		keyboard.up().onPressDo({coco.irA(coco.position().up(1))})
    }
}