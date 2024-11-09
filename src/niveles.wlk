import wollok.game.*
import personaje.*
import extras.*
import juego.*

const nivel1 = new Nivel(nivel=1, enemigos = monstruosNivel1, bloquesMapa = bloquesMapa1, image = fondoNivel1, sonidoNivel = "despues") //crear todo lo que va adentro
const nivel2 = new Nivel(nivel = 2, enemigos = monstruosNivel2, bloquesMapa = bloquesMapa2, image = fondoNivel2, sonidoNivel = "despues") //crear todo lo que va adentro
const todosLosNiveles = [nivel1, nivel2]
class Nivel{
  var property position = game.center()
  var property image
  const property nivel
  var property enemigos
  const property sonidoNivel
  var property bloquesMapa
}

const bloquesMapa1 = new Bloques(bloquesMapa=[[1, 1], [], [], []],
nivel = 1
)
const bloquesMapa2 = new Bloques(bloquesMapa = [[], [], []],
nivel = 2
)

class Bloques{
  const property bloquesMapa = []
  const property nivel
}
