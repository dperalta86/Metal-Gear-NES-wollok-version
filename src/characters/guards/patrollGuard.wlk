import src.inputManager.movements.*
import src.characters.guards.guards.Guard

class PatrollGuard inherits Guard {
    // Repito movimientos horizontales para darle mas peso en la probabilidad...
    const movements = [
        { movement.moveUp(self) },
        { movement.moveDown(self) },
        { movement.moveLeft(self) },
        { movement.moveLeft(self) },
        { movement.moveRight(self) },
        { movement.moveRight(self) }
    ]
    
    override method move() {
        const nextMove = movements.anyOne()
        nextMove.apply()
    }
}
