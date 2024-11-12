import wollok.game.*
import personaje.*
import extras.*
import juego.*

const musicaNivel1 = game.sound("musicaNivel1.wav") 
const musicaNivel2 = game.sound("musicaNivel2.wav") 
const nivel1 = new Nivel(nivel=1, enemigos = monstruosNivel1, bloquesMapa = bloquesMapa1, image = fondoNivel1, sonidoNivel = musicaNivel1,pociones = pocionesNivel1)//crear todo lo que va adentro
const nivel2 = new Nivel(nivel = 2, enemigos = monstruosNivel2, bloquesMapa = bloquesMapa2, image = fondoNivel2, sonidoNivel = "despues",pociones = pocionesNivel2) //crear todo lo que va adentro
const todosLosNiveles = [nivel1, nivel2]
class Nivel{
  var property position = game.center()
  var property image
  const property nivel
  var property enemigos //Creo que queda mejor monstruo, pero hay que cambiar en nombre todas las veces que aparece
  const  property sonidoNivel
  var property bloquesMapa
  var property pociones 

}

const bloquesMapa1 = new Bloques(murosNivel =[[1, 5], [2, 3], [2, 4], [2, 6], [2, 7], [2, 8], [2, 9], [2, 10], [2, 11], [5, 9], [5, 10], [5, 11], [6, 9], [6, 10], [6, 11],
[8, 5], [10, 10], [9, 6], [9, 7], [9, 8], [10, 6], [10, 7], [10, 8], [11, 6], [11, 7], [11, 8], [14, 8], [13, 3], [13, 4], [13, 5], [13, 6], [13, 7], [13, 9], [13, 10], [13, 11]] ,
nivel = 1
)
const bloquesMapa2 = new Bloques(murosNivel = [[], [], []],
nivel = 2
)

class Bloques{
  const property murosNivel = []
  const property nivel
}
