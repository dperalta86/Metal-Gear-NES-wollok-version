import src.characters.character.Character
import src.system.colissions.colissionHandler
import src.inputManager.movements.movement

/*
 * Clase abstracta Guard, de ella heredan las clases de los distintos tipos de guardias
 */
class Guard inherits Character {

    method collidedForSnake() { console.println(self.toString() + " colisionado por Snake!")}

    override method update() {
        if (isAlive && isActive) {
            self.move()
        }
    }
    
    // Comportamiento polimórfico (Interfaz) 
    method verifyDetection() // Lógica para detectar al jugador    
    method updateState() // Lógica para actualizar el estado    
}