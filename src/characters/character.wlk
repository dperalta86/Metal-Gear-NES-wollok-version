
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
    
    // Los personajes son colisionables por defecto
    override method esColisionable() = true
    
    /*
     * Método común para mover personajes con validación de colisiones
     * Valida límites del tablero y colisiones antes de mover
     */
    method moveTo(newPos) {
        if (self.canMoveTo(newPos)) {
            lastPosition = position
            position = newPos
            self.onPositionChanged()
        }
    }
    
    /*
     * Verifica si el personaje puede moverse a una posición
     */
    method canMoveTo(newPos) {
        return movement.canMove(newPos) && 
               !colissionHandler.hasColissionAt(newPos)
    }
    
    /*
     * Hook method: Se ejecuta cuando el personaje cambia de posición
     * Puede ser overrideado por subclases para comportamiento específico
     */
    method onPositionChanged() {
        // Por defecto no hace nada
        // Snake lo usa para verificar cambio de área
        // Guards lo usan para actualizar patrullaje
    }
    
    /*
     * Sistema de vida
     */
    method takeDamage(amount) {
        health = (health - amount).max(0)
        console.println(self.className() + " recibió " + amount + " de daño. Vida: " + health)
        
        if (health <= 0) {
            self.die()
        }
    }
    
    method heal(amount) {
        health = (health + amount).min(100)
        console.println(self.className() + " recuperó " + amount + " de vida. Vida: " + health)
    }
    
    method die() {
        isAlive = false
        self.deactivate()
        console.println(self.className() + " ha muerto") // Si es Snake, game over se maneja en otro lado
    }
    
    /*
     * Método abstracto: Cada personaje implementa su propia lógica de movimiento
     * - Snake: Movimiento controlado por teclado
     * - StaticGuard: No se mueve (o solo rota)
     * - PatrollGuard: Movimiento aleatorio/patrón
     */
    method move()
    
    /*
     * Template method: Define el flujo de actualización
     * Solo se actualiza si está vivo y activo
     */
    override method update() {
        if (isAlive && isActive) {
            self.move()
        }
    }
    
    /*
     * Manejo de colisiones - Polimórfico
     */
    override method collidedBy(other) {
        console.println(self.className() + " colisionó con " + other.className())
    }
    
    /*
     * Métodos de utilidad para dirección
     * Esto es lo que hablamos con Santi sobre la repetición en lastMovement y lastPosition etc...
     */
    method isLookingAt(otherPosition) {
        return self.getPositionInFront() == otherPosition
    }
    
    method getPositionInFront() {
        return self.getPositionInDirection(direction)
    }
    
    method getPositionInDirection(dir) {
        return if (dir == "up") {
            position.up(1)
        } else if (dir == "down") {
            position.down(1)
        } else if (dir == "left") {
            position.left(1)
        } else if (dir == "right") {
            position.right(1)
        } else {
            position
        }
    }
    
    /*
     * Distancia a otro personaje (útil para detección)
     */
    method distanceTo(otherCharacter) {
        return position.distance(otherCharacter.position())
    }
}