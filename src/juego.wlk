import personaje.*
import extras.*
import niveles.*

const monstruosNivel1 =  [new Monstruo(),  new Monstruo(), new Calabera(), new Calabera()]
const monstruosNivel2 =  [new ReyDuende(), new Monstruo(), new Calabera()]
const pocionesNivel1 = [new Pociones(x=10,y=11), new Pociones(x=4,y=5),new Pociones(x=12,y=4)]
const pocionesNivel2 = [new Pociones(x=10,y=11)] // cuando este listo el nivel 2 agrego las positions de las pociones 

//Mejorar los bloques, que estos sean objetos
//Tal vez cambiar lo del id, que cada monstruo sepa su id (yo lo dejaria como esta)
//Hacer un metodo "misionCumplida()" o algo por el estilo, con la logica de terminado de nivel

//queda:
//El jefe y la logica de habilidad especial
//(Si hay tiempo le podriamos poner una barra de vida al jefe)
//Al terminar el nivel dos poder ganar

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
        objetoNivel = nivel1
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
    self.crearNivel(objetoNivel)
  }

  method crearNivel(nivel){
    nivel.sonidoNivel().shouldLoop(true)  // Hacerlo en loop
    nivel.sonidoNivel().volume(0.2)          // Volumen 
    game.schedule(500, { nivel.sonidoNivel().play() }) // inicia musica

    game.addVisual(nivel.image()) // Crear en un archivo aparte que contenga la clase nivel
    game.addVisualCharacter(coco)
    coco.posicionInicial(nivelActual)
    self.crearVidas()
    self.configurarTeclado(nivel)
    self.perseguirACoco(nivel) //Lista con los monstruos de cada nivel, que aparezcan y que lo sigan
    self.agregarPociones(nivel)  
    self.colisionarConCoco()
    self.cocoMorir()
  }

  // method imagenBug() = game.allVisuals().filter({imagen => imagen.position() == game.at(2,2)}) Intento de encontrar el visual


  method crearVidas(){
    const vida3 = new Vidas(x=15, y=15)
    const vida2 = new Vidas(x=14, y=15)
    const vida1 = new Vidas(x=13, y=15)
    game.addVisual(vida3)
    game.addVisual(vida2)
    game.addVisual(vida1)

    game.onTick(10, "perderVidas", {self.calcularVidaPerdida(vida1,vida2,vida3)})
    game.onTick(10, "perderVidas", {self.calcularVidaRecuperada(vida1,vida2,vida3)})
  }

  method calcularVidaPerdida(c1,c2,c3) {
    if(coco.vidas() >= 2){
      c3.perderVida()
    }else if(coco.vidas() >= 1){
      c3.perderVida()
      c2.perderVida()
    } else if(coco.vidas() == 0){
      c3.perderVida()
      c2.perderVida()
      c1.perderVida()
    }
  }

  method calcularVidaRecuperada(c1,c2,c3) {
    if(coco.vidas() == 3){
      c3.recuperarVida()
      c2.recuperarVida()
      c1.recuperarVida()
    }
  }

  method colisionarConCoco(){
    game.onCollideDo(coco, {p =>
     p.colisionarConCoco()
    })
  }

  method cocoMorir(){
    game.onTick(500, "gameOver", {if(!coco.estaVivo()) self.gameOver()})
  }

  method gameOver(){
    //Logica de game over
    self.finalizarNivel()
    game.addVisual(imagenGameOver)
    nivelIniciado = false
    //PONER MUSICA
    keyboard.space().onPressDo({
      game.removeVisual(imagenGameOver)
      self.iniciarJuego()
      })
  }

  method perseguirACoco(monstruosNivel){
    //Lista con los monstruos de cada nivel, que aparezcan y que lo sigan
    monstruosNivel.enemigos().forEach({m => 
      const id = m.identity().toString()
      game.addVisual(m)
      m.perseguirACoco(id, monstruosNivel)
     })
  }

  method configurarTeclado(nivel){
    self.atacarAMonstruo(nivel)
    self.consultarVida()
    self.movimientoPersonaje()
    game.onTick(200, "comprobar", {self.pasoDeNivel()}) //Cuando funcione cambiar nivel1 para que funcione para todos
  }   

  method pasoDeNivel(){
    if(objetoNivel.enemigos().all({m => m.estaMuerto()}) and coco.position() == game.at(13, 8)) self.siguienteNivel() // or nivelObjeto == nivel2
  }

  method atacarAMonstruo(nivel) {
    keyboard.e().onPressDo({
      coco.atacar()
      nivel.enemigos().forEach({m => 
        const id  = m.identity().toString()
        if(m.position() == coco.position()) m.recibirAtaque(id, nivel)
      })
    })
  }

  method consultarVida() {
    keyboard.q().onPressDo({
      game.say(coco, "mi vida es " + coco.vidas())
    })
  }

  method siguienteNivel(){
    nivelActual += 1
    self.finalizarNivel()
    if ((nivelActual == 2)){
      objetoNivel = nivel2
      self.crearNivel(objetoNivel)
    }else
      self.pantallaGanaste()
  }

  method pantallaGanaste(){
    game.addVisual(imagenDeVictoria)
    keyboard.space().onPressDo({
      game.removeVisual(imagenDeVictoria)
      self.iniciarJuego()
    })
  }

  method finalizarNivel(){
      nivelIniciado = false
      objetoNivel.sonidoNivel().pause()
      game.clear()
  }

  //method cocoEnPosicionDeSalida() = (coco.position().x()  == 13) and (coco.position().y() == 7)
  
  method agregarPociones(pocionesDelNivel){
    //Aparecen las pociones del respectivo nivel
    pocionesDelNivel.pociones().forEach({p =>
    game.addVisual(p) 
  })
  }

  method movimientoPersonaje(){
    keyboard.right().onPressDo({coco.irHaciaDerecha(objetoNivel)})
    keyboard.left().onPressDo({coco.irHaciaIzquierda(objetoNivel)})
    keyboard.up().onPressDo({coco.irHaciaArriba(objetoNivel)})
    keyboard.down().onPressDo({coco.irHaciaAbajo(objetoNivel)})
  }
}