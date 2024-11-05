import wollok.game.*
import personaje.*
import extras.*
object nivel1{
    const monstruo1 = new Monstruo()
    method iniciar(){
        game.addVisualCharacter(coco)
        game.addVisual(monstruo1)
        config.configurarTeclas()
        monstruo1.caminar(1300)
    }

    
}
//object nivel2{
    //const monstruo1 = new Monstruo()
   // var property resultado = false
   // method iniciar(){
    //    game.addVisualCharacter(coco)
   //     game.addVisual(monstruo1)
    //    game.onTick(200, "perseguirPersonaje", {monstruo1.perseguirPersonaje()})
    //    config.configurarTeclas()
   // }
   // method superarNivel() {
    //    if (!monstruo1.estaVivo()) {
     //       resultado = true
     //   }
  //  }
//}

object config {
  method configurarTeclas() {
    self.atacarAMonstruo()
  }

  method atacarAMonstruo() {
   keyboard.e().onPressDo({coco.atacar()})
  }
  //keyboard.r().onPressDo({coco.rotarArma()})
   
}
