import wollok.game.*

/*
 * Clase abstracta base para todos los objetos del juego
 * Define la interfaz común que todos los objetos deben implementar
 */
class GameObject {
    var property position
    var property isActive = false // Indica si el objeto está actualmente en el área
    var canBeCollided = false 
    
    method image() // Abstract - implementar en subclases
    
    method esColisionable() = canBeCollided
    
    method canBeCollided(valor) {
        canBeCollided = valor
    }
    
    // Activa el objeto (lo hace visible y colisionable)
    method activate() {
        if (!isActive) {
            game.addVisual(self)
            isActive = true
        }
    }
    
    // Desactiva el objeto (lo oculta y quita colisión)
    method deactivate() {
        if (isActive) {
            game.removeVisual(self)
            isActive = false
        }
    }
    
    // Método para manejar colisiones - polimórfico
    method collidedBy(character) {
        // Por defecto no hace nada, las subclases sobrecargan (override) según necesiten
    }
    
    method update() {
        // Idem anterior
    }
}