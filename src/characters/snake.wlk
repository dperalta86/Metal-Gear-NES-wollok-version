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
     * Snake no se mueve automáticamente
     * El movimiento es controlado por el teclado (inputManager)
     */
    override method move() {
        // Movimiento controlado externamente por teclado
        // Este método existe para cumplir con la interfaz de Character
    }
    
    /*
     * Método específico para movimiento por input del teclado
     * Llamado desde inputManager cuando el jugador presiona teclas
     */
    method moveToByInput(newPos, newDirection) {
        if (self.canMoveTo(newPos)) {
            lastPosition = position
            position = newPos
            lastMovement = newDirection
            direction = newDirection
            
            // Hook: Verificar cambio de área después de moverse
            self.onPositionChanged()
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
        console.println("Snake colisionó con: " + other.className())
        
        // Si choca con algo colisionable (guardia, muro), retrocede no lo "pisa"
        if (other.esColisionable()) {
            position = lastPosition
        }
    }
    
    /*
     * Sistema de daño
     */
/*     override method takeDamage(amount) {
        super(amount)
        // TODO: Efectos visuales de daño
        // TODO: Sonido de daño
    } */
    
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