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

const bloquesMapa1 = new Bloques(bloquesNorte=[[2, 5], [3, 11], [4, 11], [5, 8], [6, 8], [7, 11], [8, 11], [9, 11], [10, 11], [11, 11], [12, 11], [10, 9], 
[13, 8], [11, 5], [10, 5], [9, 5], [8, 4]] ,
bloquesEste=[[4, 11], [4, 10], [4, 9], [8, 8], [8, 7], [8, 6], [7, 5], [9, 10], [12, 11], [12, 10], [12, 9], [13, 8], [12, 7], [12, 6], [12, 5], [12, 4], [12, 3]], 
bloquesSur=[[2, 5], [8, 6], [10, 11], [9, 9], [10, 9], [9, 11], [8, 13], [3, 3], [4, 3], [5, 3], [6, 3], [7, 3], [8, 3], [9, 3], [10, 3], [11, 3], [12, 3]],
bloquesOeste=[[2, 5], [3, 3], [3, 4], [3, 6], [3, 7], [3, 8], [3, 9], [3, 10], [3, 11], [7, 9], [7, 10], [7, 11], [9, 5], [11, 10], [12, 7], [12, 6]],
nivel = 1
)
const bloquesMapa2 = new Bloques(bloquesNorte = [[], [], []],
nivel = 2
)

class Bloques{
  const property bloquesNorte = []
  const property bloquesEste = []
  const property bloquesSur = []
  const property bloquesOeste = []
  const property nivel
}
