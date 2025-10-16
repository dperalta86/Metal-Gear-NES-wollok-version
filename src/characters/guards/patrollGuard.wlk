import src.inputManager.movements.*
import wollok.game.* // Es necesario importar wollok.game.* cuando defino una clase?

import src.characters.guards.guards.Guard

class PatrollGuard inherits Guard {
    override method image() = "patroll_guard.png"
    
    override method move() {
        const nextMove = self.getMovement()
        nextMove.apply()
    }
 
    override method verifyDetection() { }
    override method updateState() { }

    method getMovement() {
        // Repito movimientos horizontales para darle mas peso en la probabilidad...
        const movements = [
            { movement.moveUp(self) },
            { movement.moveDown(self) },
            { movement.moveLeft(self) },
            { movement.moveLeft(self) },
            { movement.moveRight(self) },
            { movement.moveRight(self) }
        ]
        return movements.anyOne() // elige una closure al azar
    }
    
}

// Instancio guardias de nivel 01

// Area01
const patroll01 = new PatrollGuard (position = game.at(5,9), lastPosition = game.at(5,9))

// Area02
const patroll02 = new PatrollGuard (position = game.at(2,8), lastPosition = game.at(2,8))

// Area 03
const patroll03 = new PatrollGuard (position = game.at(4,5), lastPosition = game.at(4,5))

// Area04
const patroll04A = new PatrollGuard (position = game.at(6,10), lastPosition = game.at(6,10))
const patroll04B = new PatrollGuard (position = game.at(14,3), lastPosition = game.at(14,3))
