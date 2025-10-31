import wollok.game.*

/*
 * Definición base para todos los fondos visuales
 * (idea: https://github.com/wollok/bobEsponjaGame  )
 * No tienen interacción, solo son imágenes de fondo
*/
class Visual {
	var property image
	var property position = game.origin()

    method collidedBy(other) {  }
}

// Inicio
const start = new Visual(
	image = "intro.gif",
    position = game.at(3,4)
)

const startMessage = new Visual(
    image = "intro-message.gif",
    position = game.at(5,1)
)

// Fondos en nivel 1
const area01BG = new Visual(
    image = "level01-01.png",
    position = game.origin()
)

const area02BG = new Visual(
    image = "level01-02.png",
    position = game.origin()
)

const area03BG = new Visual(
    image = "level01-03.png",
    position = game.origin()
)

const area04BG = new Visual(
    image = "level01-04.png",
    position = game.origin()
)

const area05BG = new Visual(
    image = "level01-05.png",
    position = game.origin()
)