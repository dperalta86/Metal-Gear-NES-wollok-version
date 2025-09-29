import src.levels.level01.*
import src.levels.areaManager.areaManager
object solidSnake{
  var property position=game.origin()
  var property lastMovement="right"

  method image()="snake_"+self.lastMovement()+".png"

  method update() { } // TODO: Implementar
  method esColisionable() = false

  method moveTo(nuevaPos) {
    if (self.canMove(nuevaPos)) {
        position = nuevaPos
        // Verificar transiciones después del movimiento
        areaManager.verifyTransition()
    }
  }
  
  method canMove(pos) {
    // TODO: verificarColisiones(pos)
    return pos.x() >= 0 && pos.x() < game.width() && 
            pos.y() >= 0 && pos.y() < game.height()
  }
}