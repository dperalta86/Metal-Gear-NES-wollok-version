import src.levels.level01.*

/*
 * Manejador de areas y transiciones entre ellas
 */
class ChangeAreaEvent {
    const property postion
    const property nextDirection // "up", "down", "left", "right"
    const property goToArea // Area a la que se quiere ir
    var isCharacterOnPosition = false
    var isCharacterOnDirection = false

    // Por mas que solo tengamos a Snake como personaje, utilizo "character" para futuras expansiones
    method canCharacterChangeArea(character) {
        isCharacterOnPosition = character.position().equals(postion)
        isCharacterOnDirection = character.lastMovement().equals(nextDirection)
        return isCharacterOnPosition && isCharacterOnDirection
    }

    method trychangeArea(character) {
        if (self.canCharacterChangeArea(character)) {
            areaManager.changeArea(goToArea)
        }
    }
}

/*
object areaManager {
    var actualArea = centralArea

    method changeArea(newArea, initialPosition) {
        actualArea.removeArea()
        actualArea = newArea
        actualArea.load()
        solidSnake.position(initialPosition)
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
    }
}

*/