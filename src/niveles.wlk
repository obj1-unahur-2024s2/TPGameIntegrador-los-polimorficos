import wollok.game.*
import personaje.*
import extras.*
object nivel1{
    const monstruo1 = new Monstruo()
    method iniciar(){
        game.addVisualCharacter(coco)
        game.addVisual(monstruo1)
        game.onTick(1000, "perseguirPersonaje", {monstruo1.perseguirPersonaje()})
       // config.configurarTeclas()
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

//object config {
  //     keyboard.e().onPressDo({coco.hacerDanio()})
  //     keyboard.r().onPressDo({coco.rotarArma()})
   // }
//}