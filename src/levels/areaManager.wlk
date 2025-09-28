import src.characters.snake.solidSnake
import src.levels.level01.*


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