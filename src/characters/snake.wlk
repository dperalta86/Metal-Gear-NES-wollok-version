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
    override method image() = "snake_" + lastMovement + ".png"
    
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
            position = lastPosition
        }
        // TODO: si el objeto es un guardia, Snake pierde vida o muere (detección)

    }

    
    override method die() {
        super()
        console.println("GAME OVER")
        // TODO: Mostrar pantalla de game over
        // TODO: Reproducir sonido de muerte
    }
    
    // TODO: Métodos adicionales específicos de Snake (usar objetos, agacharse, etc.)
}

const solidSnake = new Snake(
    position = game.origin(),
    lastPosition = game.origin(),
    movementSpeed = 1
)