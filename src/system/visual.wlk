import wollok.game.*

/*
 * Definición base para todos los fondos visuales
 * (idea: https://github.com/wollok/bobEsponjaGame  )
*/
class Visual {
	var property image
	var property position = game.origin()
}

// Inicio
const start = new Visual(
	image = "intro.gif",
    position = game.origin()
)

object startMessage {
    method position() = game.at(2, 10) 
    method text() = "Presiona ESPACIO para comenzar..."
}

const cetralAreaBG = new Visual(
    image = "central.jpg",
    position = game.origin()
)

const northAreaBG = new Visual(
    image = "north.jpg",
    position = game.origin()
)

const southAreaBG = new Visual(
    image = "south.jpg",
    position = game.origin()
)

const eastAreaBG = new Visual(
    image = "east.jpg",
    position = game.origin()
)

const westAreaBG = new Visual(
    image = "west.jpg",
    position = game.origin()
)