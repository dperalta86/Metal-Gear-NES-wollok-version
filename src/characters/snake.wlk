import src.ui.hud.hud
import src.gameManager.gameManager
import src.characters.character.Character
import src.inputManager.movements.*
import src.system.colissions.*
import src.levels.level01.*
import src.levels.areaManager.areaManager

/*
 * Solid Snake - Personaje principal controlado por el jugador
 * Hereda de Character pero tiene comportamiento único
 */
class Snake inherits Character {
    var currentItem = null
    var equipment = []
    override   method image() {
        if (currentItem != null) {
            return currentItem.image()
        } else {
            return "snake_" + self.lastMovement() + ".png"
        }
    }
    
    /*
     * Hook: Se ejecuta después de cambiar de posición
     */
    override method onPositionChanged() {
        // Verificar si Snake debe cambiar de área
        areaManager.update(self)
        
    }
    
    /*
     * Colisión con otros objetos
     */
    override method collidedBy(other) {
        console.println("Snake collided with: " + other.className())
        if (other.isActive() && other.canBeCollided()) {
            self.takeDamage(20)
            position = lastPosition
        }
        // TODO: si el objeto es un guardia, Snake pierde vida o muere (detección)

    }

    override method takeDamage(amount) {
        super(amount)
        hud.lostHeart()
    }
    
    override method die() {
        super()
        gameManager.gameOver()
    }
    
    // TODO: Métodos adicionales específicos de Snake (usar objetos, agacharse, etc.)
        method equipItem() {
        if (currentItem != null) {
            self.giveUpItem()
        } else {
           colissionHandler.processInteraction(self)
        }
    }

    method pickUpItem(item) {
        currentItem = item
    }


    method giveUpItem() {

        if (currentItem != null) {
            currentItem.position(self.position())
            game.addVisual(currentItem)
        }
        
        currentItem = null 
    }

}

const solidSnake = new Snake(
    position = game.origin(),
    lastPosition = game.origin(),
    movementSpeed = 1
)