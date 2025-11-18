import src.utils.log.*
import wollok.game.*

/*
 * Clase abstracta base para todos los objetos del juego
 * Define la interfaz común que todos los objetos deben implementar
 */
class GameObject {
    var position
    var isActive = false
    const isCollidable = false
    const isPickable = false

    // Si es colisionable (isCollidable = true) puede estar "desactivado" para ser colisionado
    var canBeCollided = false 
    
    method image() // Abstract - debe implementarse en subclases

    // getters y setters
    method position() = position
    method isActive() = isActive
    method canBeCollided() = canBeCollided
    method isCollidable() = isCollidable
    method isPickable() = isPickable

    method position(pos) { position = pos }
    method canBeCollided(valor) { canBeCollided = valor }

    // Activa lógicamente el objeto
    method activate() {
        canBeCollided = true
        isActive = true
    }
    
    // Desactiva lógicamente el objeto
    method deactivate() {
        canBeCollided = false
        isActive = false
    }

    // collidedBy()
    method collidedBy(character) {
        log.debug(self, "colisionado por " + character)
    }
    // Actualización por tick
    method update() {}
}