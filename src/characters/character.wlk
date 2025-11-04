import src.utils.utils.utils
import src.utils.log.log

import wollok.game.*
import src.gameObject.GameObject
import src.system.colissions.colissionHandler
import src.inputManager.movements.movement

/*
 * Clase abstracta Character
 * Base para todos los personajes que se mueven en el juego (Snake y Guards)
 * Proporciona comportamiento común de movimiento, vida y actualización
 */
class Character inherits GameObject {
    var property lastPosition = game.origin()
    var property lastMovement = "right"
    var property direction = "down"
    var property health = 100
    var property isAlive = true
    var property movementSpeed = 1 // Tiles por movimiento

    method lastMovement() = lastMovement
    
    /*
     * Método común para mover personajes con validación de colisiones
     * Valida límites del tablero y colisiones antes de mover
     */
    method moveTo(newPos) {
        if (movement.canMove(newPos)) {
            lastPosition = position
            position = newPos
            self.onPositionChanged()
        }
    }
    
    /*
     * Hook method: Se ejecuta cuando el personaje cambia de posición
     * Puede ser overrideado por subclases para comportamiento específico
     */
    method onPositionChanged() {
        // Por defecto no hace nada
        // Snake lo usa para verificar cambio de área
        // Guards lo usan para actualizar patrullaje ¿?
    }
    
    /*
     * Sistema de vida
     */
    method takeDamage(amount) {
        if(isAlive){
            health = (health - amount).max(0)
            log.debug(self, utils.getClassName(self) + " recibió " + amount + " de daño. Vida: " + health)
            
            if (health <= 0) {
                self.die()
            }
        }      
    }

    
    method heal(amount) {
        health = (health + amount).min(100)
        log.debug(self, utils.getClassName(self) + " recuperó " + amount + " de vida. Vida: " + health)
    }
    
    method die() {
        isAlive = false
        self.deactivate()
        log.debug(self, utils.getClassName(self) + " ha muerto") // Si es Snake, game over se maneja en otro lado
    }

    
    /*
     * Manejo de colisiones
     */
    override method collidedBy(other) {
        if (other.isActive() && other.canBeCollided()) {
            self.takeDamage(20)
            if(utils.getClassName(other) != "Bullet" || utils.getClassName(other) !="Health"){
                position = lastPosition
            }

        }
    }
}