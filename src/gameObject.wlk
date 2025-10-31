import wollok.game.*

/*
 * Clase abstracta base para todos los objetos del juego
 * Define la interfaz común que todos los objetos deben implementar
 */
class GameObject {
    var position
    var isActive = false // Indica si el objeto está actualmente en el área
    var canBeCollided = false 
    
    method image() // Abstract - implementar en subclases

    method position(pos) {
        position = pos
    }
    method position() = position

    method isActive() = isActive
    
    method canBeCollided() = canBeCollided    
    method canBeCollided(valor) {
        canBeCollided = valor
    }
    
method activate() {
    canBeCollided = true
    isActive = true
}
    
method deactivate() {
    canBeCollided = false
    isActive = false
}

    
    // Método para manejar colisiones - polimórfico
    method collidedBy(character) {
        // Por defecto no hace nada, las subclases sobrecargan (override) según necesiten
    }
    
    method update() {
        // Idem anterior
    }
}