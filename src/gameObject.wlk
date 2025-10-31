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

    method isActive() = isActive
    
    method canBeCollided() = canBeCollided    
    method canBeCollided(valor) {
        canBeCollided = valor
    }
    
    // Activa el objeto (lo hace visible y colisionable)
    method activate() {
    if (!game.hasVisual(self)) {
        console.println("obj")
    }
    canBeCollided = true
    isActive = true
}

    
    // Desactiva el objeto (lo oculta)
    method deactivate() {
        canBeCollided = false
        isActive = false
        if (game.hasVisual(self)){
            game.removeVisual(self)
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