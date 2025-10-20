import src.inputManager.movements.*
import src.system.colissions.*
import src.levels.level01.*
import src.levels.areaManager.areaManager
object solidSnake{
  var property position = game.origin()
  var property lastPosition = game.origin()
  var property lastMovement = "right"

  var property currentItem = null

  method esColisionable() = false
  method esItem() = false

  method image() {
        if (currentItem != null) {
            return currentItem.image()
        } else {
            return "snake_" + self.lastMovement() + ".png"
        }
    }

  method update() { } // TODO: Implementar
  method collidedForGuard(guard){
    console.println("snake colisionó un guardia...")
    if (guard.canBeCollided()){
      position = lastPosition
    }

  }

 method moveTo(newPos) {
        
        // if (currentItem != null) {
        //     self.dejarItem()
        // }

        if (movement.canMove(newPos) && !colissionHandler.verifyColission(newPos)) {
            lastPosition = position
            position = newPos
        }
        areaManager.update(self)
    }


    method accionUsarItem() {
        if (currentItem != null) {
            self.dejarItem()
        } else {
           colissionHandler.processInteraction(self)
        }
    }

    method equiparItem(item) {
        currentItem = item
    }


    method dejarItem() {

        if (currentItem != null) {
            currentItem.position(self.position())
            game.addVisual(currentItem)
        }
        
        currentItem = null 
    }

// con este metodo podemos cambiar de area estando parado sobre la posicion de cambio de area
  // method moveTo(nuevaPos) {
  //   var change = areaManager.update(self) // Evento para verificar si se cambia de area
  //   if (self.canMove(nuevaPos) && !change) {
  //       position = nuevaPos
  //       console.println(self.position())
  //   }
  // }
  
  }