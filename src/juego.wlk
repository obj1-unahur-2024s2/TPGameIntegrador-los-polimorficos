import personaje.*
import extras.*
import niveles.*

const monstruosNivel1 =  [new Monstruo(),  new Monstruo()]
const monstruosNivel2 =  (0..2).map({num => new Monstruo()})
object juego{
  var nivelActual = 0 
  var nivelIniciado = false

  method nivelIniciado() = nivelIniciado
  method nivelActual() = nivelActual
  method nivelIniciado(estaIniciado){nivelIniciado = estaIniciado}

  method iniciarJuego(){
    self.prepararPantallaDeInicio()
    keyboard.space().onPressDo{
      if(!self.nivelIniciado())
        game.removeVisual(imagenInicial)//Hacer lo de la imagen inicial
        nivelActual = 1
        self.prepararJuego(nivel1)
        self.nivelIniciado(true)
    }
  }

  method prepararPantallaDeInicio(){
    game.title("CocoAdventure")
    game.width(16)
    game.height(16)
	  game.cellSize(32)
    game.boardGround("fondoNegro1.jpg")//fondo.jpg
    game.addVisual(imagenInicial)
  }

  method prepararJuego(nivel){
    game.title("CocoAdventure")
    game.width(16)
    game.height(16)
	  game.cellSize(32)
    self.crearNivel(nivel)
  }

  method crearNivel(nivel){
    game.addVisual(nivel.image()) // Crear en un archivo aparte que contenga la clase nivel
    game.addVisualCharacter(coco)
    self.crearVidas()
    self.configurarTeclado()
    self.perseguirACoco(nivel) //Lista con los monstruos de cada nivel, que aparezcan y que lo sigan
    self.agregarBloques(nivel) // Crear los bloques por donde no puede pasar el personaje
  }

  method crearVidas(){
    const vida3 = new Vidas(x=15, y=15)
    const vida2 = new Vidas(x=14, y=15)
    const vida1 = new Vidas(x=13, y=15)
    game.addVisual(vida3)
    game.addVisual(vida2)
    game.addVisual(vida1)
  }

  method perseguirACoco(monstruosNivel){
    //Lista con los monstruos de cada nivel, que aparezcan y que lo sigan
    monstruosNivel.enemigos().forEach({m =>
     const id = m.identity().toString()
     game.addVisual(m) 
     m.perseguirACoco(800, id)
     })
  }

  method configurarTeclado(){
    self.atacarAMonstruo()
    self.consultarVida()
    game.onTick(2000, "comprobar", {if(nivel1.enemigos().size()  ==  0) self.siguienteNivel()}) //Cuando funcione cambiar nivel1 para que funcione para todos
  }

  method atacarAMonstruo() {
   keyboard.e().onPressDo({
    coco.atacar()
    game.whenCollideDo(coco, {m =>
     const id  = m.identity().toString()
     m.recibirAtaque(id)})
    })
  }

  method consultarVida() {
    keyboard.q().onPressDo({
      game.say(coco, "mi vida es " + coco.vidas())
    })
  }

  method agregarBloques(nivel){
    // Crear los bloques por donde no puede pasar el personaje de cada nivel
  }

  method siguienteNivel(){
    nivelActual += 1
    self.finalizarNivel()
    if ((nivelActual < 2) and (self.cocoEnPosicionDeSalida())){
      self.prepararJuego(nivel2)
    }else
      game.addVisual(imagenDeVictoria)
  }

  method finalizarNivel(){
      game.clear()
      coco.posicionInicial(2)
  }

  method cocoEnPosicionDeSalida() = (coco.position().x()  == 13) and (coco.position().y() == 7)
  
    //Aca va a estar toda la logica de el juego
    //Pantalla de inicio, pantalla de game over
    //Limpiar los visuales al cambiar de nivel, poder cambiar de nivel al ir a la puerta
}