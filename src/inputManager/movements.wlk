import src.characters.snake.solidSnake
import wollok.game.*
import src.system.colissions.colissionHandler
import src.levels.level01.*



/*
 * Definición base para todos los movimientos de todos los personajes.
*/
object movement {
    method moveUp(character) {
        character.lastMovement("up")
        character.moveTo(character.position().up(1))
    }

    method moveDown(character) {
        character.lastMovement("down")
        character.moveTo(character.position().down(1))
    }

    method moveLeft(character) {
        character.lastMovement("left")
        character.moveTo(character.position().left(1))
    }

    method moveRight(character) {
        character.lastMovement("right")
        character.moveTo(character.position().right(1))
    }

    method canMove(pos) {
        return pos.x() >= 0 && pos.x() < game.width() && 
        pos.y() >= 0 && pos.y() < game.height()
  }

    // Cada 10 segundos (el ciclo de patrulla es de 6s) reinicio el movimiento de todos los guardias
    // TODO: Ver si se puede mejorar performance activando/desactivando movimiento de los guardias
    // según el area donde se encuentre Snake...
    method launchGuardsMovements(){
        game.onTick(10000, "guardsMovements", { self.restartGuardsMovements() })
    }

    method restartGuardsMovements() {
        allRegisteredAreas.forEach { area =>
            area.guards().forEach { guard =>
                guard.comportamiento()
            }
        }
    }
}