import src.system.colissions.colissionHandler
import src.inputManager.movements.movement
import wollok.game.* // Es necesario importar wollok.game.* cuando defino una clase?

/*
 * Clase abstracta Guard, de ella heredan las clases de los distintos tipos de guardias
 */
class Guard {
    var property position
    var property lastPosition
    var property direction = "down"
    var property lastMovement = "right"
    var property state = "patrolling" // Por el momento no se va a utilizar...
    var property detectionRange = 3 // Idem
    var property canBeCollided = false

    method collidedForSnake() { console.println(self.toString() + " colisionado por Snake!")}
    method image() 

    method canBeCollided(valor) {
        canBeCollided = valor
    }

    method esColisionable() = true

    method moveTo(newPos) {
    // Envío mensaja a collisionHandler
    // si no hay colisión, snake se mueve
    if (movement.canMove(newPos) && !colissionHandler.verifyColission(newPos)) {
      lastPosition = position
      position = newPos
    }
    }
    
    method update() {
        self.comportamiento()
        self.verificarDeteccion()
        self.actualizarEstado()
    }
    // Comportamiento polimórfico (Interfaz)
    method comportamiento() // Implementado en subclases    
    method verificarDeteccion() // Lógica para detectar al jugador    
    method actualizarEstado() // Lógica para actualizar el estado    

}