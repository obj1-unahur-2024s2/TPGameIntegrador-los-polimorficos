import wollok.game.*
import personaje.*
import extras.*
object nivel1{
  const monstruo1 = new Monstruo()
  const monstruo2 = new Monstruo()
  method iniciar(){
    game.addVisualCharacter(coco)
    game.addVisual(monstruo1)
    game.addVisual(monstruo2)

    config.atacarAMonstruo()
    config.consultarVida()

    monstruo1.caminar(1300)
    monstruo2.caminar(1100)
    self.vidas()
    game.whenCollideDo(monstruo1, {m => m.perderVida()})
    game.whenCollideDo(monstruo2, {m => m.perderVida()})
    // game.whenCollideDo(coco, {m => m.recibirAtaque()})


  }

  method muerteDeMostruo() {
    if(monstruo1.estaVivo()){
      game.removeVisual(monstruo1)
    }
  }

  method vidas(){
    const vida3 = new Vidas(x=15, y=15)
    const vida2 = new Vidas(x=14, y=15)
    const vida1 = new Vidas(x=13, y=15)
    game.addVisual(vida3)
    game.addVisual(vida2)
    game.addVisual(vida1)

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
  method atacarAMonstruo() {
   keyboard.e().onPressDo({
    coco.atacar()
    game.whenCollideDo(coco, {m => m.recibirAtaque()})
    })
  }

  method consultarVida() {
    keyboard.q().onPressDo({
      game.say(coco, "mi vida es " + coco.vidas())
    })
  }
}
