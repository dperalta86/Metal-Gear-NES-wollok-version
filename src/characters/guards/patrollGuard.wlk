import src.inputManager.movements.*
import src.characters.guards.guards.Guard

class PatrollGuard inherits Guard {
    
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
