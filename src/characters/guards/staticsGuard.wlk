import src.inputManager.movements.*
import src.characters.guards.guards.Guard


class StaticGuard inherits Guard {
    var moveCount=0
    // Comportamiento polimórfico (Interfaz)
    override method move(){
        moveCount +=1
        // Cada 20 ticks realiza movimiento, justo 16, si se "pasa" es porque ya está realizando el movimiento
        if(moveCount==16){
            self.getMove()
        }
    } 

    method getMove() {
        movement.moveDown(self)
        game.schedule(500, {movement.moveDown(self)})
        game.schedule(1000, {movement.moveLeft(self)})
        game.schedule(1500, {movement.moveRight(self)})
        game.schedule(2000, {movement.moveRight(self)})
        game.schedule(2500, {movement.moveLeft(self)})
        game.schedule(3000, {movement.moveUp(self)})
        game.schedule(3500, {movement.moveUp(self)})
        moveCount = 0 // Reinicio el contador      
    }
}