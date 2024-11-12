import personaje.*
import extras.*
import niveles.*

const monstruosNivel1 =  [new Monstruo(),  new Monstruo()]
const monstruosNivel2 =  (0..2).map({num => new Monstruo()})
const pocionesNivel1 = [new Pociones(x=10,y=11), new Pociones(x=4,y=5),new Pociones(x=12,y=4)]
const pocionesNivel2 = [] // cuando este listo el nivel 2 agrego las positions de las pociones 

object juego{
  var nivelActual = 0 
  var nivelIniciado = false
  var objetoNivel = nivel1
  const musicaInicio = game.sound("musicaDeInicio.wav")
  
  method nivelIniciado() = nivelIniciado
  method nivelActual() = nivelActual
  method nivelIniciado(estaIniciado){nivelIniciado = estaIniciado}

  method iniciarJuego(){


    musicaInicio.shouldLoop(true)  // Hacerlo en loop
    musicaInicio.volume(0.1)          // Volumen 
    game.schedule(500, { musicaInicio.play() }) // inicia musica


    self.prepararPantallaDeInicio()
    keyboard.space().onPressDo{
      if(!self.nivelIniciado())
        musicaInicio.stop()
        game.removeVisual(imagenInicial)//Hacer lo de la imagen inicial
        nivelActual = 1
        self.prepararJuego()
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

  method prepararJuego(){

    game.title("CocoAdventure")
    game.width(16)
    game.height(16)
	  game.cellSize(32)
    self.crearNivel(objetoNivel)
  }

  method crearNivel(nivel){

    nivel.sonidoNivel().shouldLoop(true)  // Hacerlo en loop
    nivel.sonidoNivel().volume(0.5)          // Volumen 
    game.schedule(500, { nivel.sonidoNivel().play() }) // inicia musica

    game.addVisual(nivel.image()) // Crear en un archivo aparte que contenga la clase nivel
    game.addVisualCharacter(coco)
    coco.posicionInicial(nivelActual)
    self.crearVidas()
    self.configurarTeclado(nivel)
    self.perseguirACoco(nivel) //Lista con los monstruos de cada nivel, que aparezcan y que lo sigan
    self.agregarBloques(nivel) // Crear los bloques por donde no puede pasar el personaje
    self.agregarPociones(nivel)  
    self.tomarPociones()
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

  method configurarTeclado(nivel){
    self.atacarAMonstruo(nivel)
    self.consultarVida()
    self.movimientoPersonaje()
    game.onTick(2000, "comprobar", {if(objetoNivel.enemigos().size()  ==  0) self.siguienteNivel()}) //Cuando funcione cambiar nivel1 para que funcione para todos
  }

    //nivel.BloquesMapa().bloqueNorte().filter({m => m == p.position()})
    //nivel.BloquesMapa().BloquesEste().filter({m => m == p.position()})
    //nivel.BloquesMapa().BloquesSur().filter({m => m == p.position()})  NO SE ME OCURRE QUE HACER
    //nivel.BloquesMapa().BloquesOeste().filter({m => m == p.position()})

  method atacarAMonstruo(nivel) {
   keyboard.e().onPressDo({
    coco.atacar()
    nivel.enemigos().forEach({m => 
      const id  = m.identity().toString()
      if(m.position() == coco.position()) m.recibirAtaque(id)})
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
    if ((nivelActual == 2)){
      objetoNivel = nivel2
      self.prepararJuego()
    }else
      objetoNivel = nivel1
      game.addVisual(imagenDeVictoria)
  }

  method finalizarNivel(){
      objetoNivel.sonidoNivel().pause()
      game.clear()
      objetoNivel.sonidoNivel().pause()
      coco.posicionInicial(2)
  }

  //method cocoEnPosicionDeSalida() = (coco.position().x()  == 13) and (coco.position().y() == 7)
  
    //Aca va a estar toda la logica de el juego
    //Pantalla de inicio, pantalla de game over
    //Limpiar los visuales al cambiar de nivel, poder cambiar de nivel al ir a la puerta


    method agregarPociones(pocionesDelNivel){
      //Aparecen las pociones del respectivo nivel
      pocionesDelNivel.pociones().forEach({p =>
      game.addVisual(p) 
    })
    }

    method tomarPociones() {
      game.onCollideDo(coco, {p => p.curar()
      
      })
      
    }

    method movimientoPersonaje(){
      keyboard.right().onPressDo({coco.irHaciaDerecha(objetoNivel)})
      keyboard.left().onPressDo({coco.irHaciaIzquierda(objetoNivel)})
      keyboard.up().onPressDo({coco.irHaciaArriba(objetoNivel)})
      keyboard.down().onPressDo({coco.irHaciaAbajo(objetoNivel)})
    }
}