import src.levels.level01.*

/*
 * Manejador de areas y transiciones entre ellas
 */
class ChangeAreaEvent {
    const property currentArea // Area actual 
    const property position // posición de cambio entre areas
    const property nextDirection // "up", "down", "left", "right"
    const property goToArea // Area a la que se quiere ir
    const property nextAreaPosition // posición donde inicia en la nueva area

    // var isCharacterOnPosition = false
    // var isCharacterOnDirection = false

    // Por mas que solo tengamos a Snake como personaje, utilizo "character" para futuras expansiones
    method canCharacterChangeArea(character) {
        return character.position().equals(position) &&
               character.lastMovement().equals(nextDirection)
    }
}

object areaManager {
    var actualArea = area01

    method update(character) {
        const event = actualArea.checkAreaChange(character)
        if (event != null) {
            self.changeArea(character, event)
        }
    }

    method changeArea(character, event) {
        actualArea.removeArea()
        actualArea = event.goToArea()
        actualArea.load()
        character.position(event.nextAreaPosition())
    }
}


/*
object areaManager {
    var actualArea = area01

    method changeArea(character, changeAreaEvent) {
        actualArea.removeArea()
        actualArea = changeAreaEvent.goToArea()
        actualArea.load()
        character.position(changeAreaEvent.nextAreaPosition())
    }


    method verifyTransition() {
        const pos = solidSnake.position()

        if (pos.y() <= 0) { 
            const destiny = actualArea.northConnection()
            if (destiny != null) {
                self.changeArea(destiny, game.at(pos.x(), game.height() - 1))
            }
        }
        else if (pos.y() >= game.height() - 1) { 
            const destiny = actualArea.southConnection()
            if (destiny != null) {
                self.changeArea(destiny, game.at(pos.x(), 0))
            }
        }
        else if (pos.x() >= game.width() - 1) { // Este
            const destiny = actualArea.eastConnection()
            if (destiny != null) {
                self.changeArea(destiny, game.at(0, pos.y()))
            }
        }
        else if (pos.x() <= 0) { // Oeste
            const destiny = actualArea.westConnection()
            if (destiny != null) {
                self.changeArea(destiny, game.at(game.width() - 1, pos.y()))
        } 
    }

*/
