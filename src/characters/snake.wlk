import src.levels.level01.*
import src.levels.areaManager.areaManager
object solidSnake{
  var property position = game.origin()
  var property lastMovement = ""

  method image()="snake_"+self.lastMovement()+".png"

  method update() { } // TODO: Implementar
  method esColisionable() = false

  method moveTo(nuevaPos) {
    if (self.canMove(nuevaPos)) {
        position = nuevaPos
    }
    areaManager.update(self) // Evento para verificar si se cambia de area
  }
  
  method canMove(pos) {
    // TODO: verificarColisiones(pos)
    return pos.x() >= 0 && pos.x() < game.width() && 
            pos.y() >= 0 && pos.y() < game.height()
  }
}