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
    position = game.at(3,4)
)

const startMessage = new Visual(
    image = "intro-message.gif",
    position = game.at(5,1)
)

const cetralAreaBG = new Visual(
    image = "level01-01.png",
    position = game.origin()
)

const northAreaBG = new Visual(
    image = "level01-02.png",
    position = game.origin()
)

const southAreaBG = new Visual(
    image = "level01-03.png",
    position = game.origin()
)

const eastAreaBG = new Visual(
    image = "level01-04.png",
    position = game.origin()
)

const westAreaBG = new Visual(
    image = "level01-05.png",
    position = game.origin()
)